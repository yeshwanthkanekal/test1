import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/circular_indicator.dart';
import 'fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<String> fetchPost(BuildContext context,String transid,String item,int noofplates,String totcost,String user) async {
  // String e = Strings.concatAll(["hello", "world"]);

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      final response =
      await http.get('http://35.186.156.206/payments.php?txnid=$transid&user=$user&item=$item&noofplates=$noofplates&cost=$totcost');

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        if(response.body.toString().contains('Message has been sent')){
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Order Successful",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              bgcolor: "green",
              textcolor: "black"
          );

        }
        else{
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Payment Failed",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              bgcolor: "#e74c3c",
              textcolor: '#ffffff'
          );
        }

        return response.body.toString();
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    }
    else{
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          bgcolor: "#e74c3c",
          textcolor: '#ffffff'
      );
      return '';
    }
  } on SocketException catch (_) {
    print('not connected');
    Navigator.of(context).pop();
    Fluttertoast.showToast(
        msg: "No Internet Connection",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        bgcolor: "#e74c3c",
        textcolor: '#ffffff'
    );
  }
  return '';

}

class UpiDemo extends StatefulWidget {
  final String value28;
  final String items28;
  final int counts28;
  final String user28;
  UpiDemo({Key key,@required this.value28,@required this.items28,@required this.counts28,@required this.user28}) : super (key: key);
  @override
  _UpiDemoState createState() => new _UpiDemoState();
}

class _UpiDemoState extends State<UpiDemo> {
  static const platform = const MethodChannel('upi/tez');
  String payeeAddress;
  String payeeName;
  String transactionNote;
  String amount;
  String currencyUnit;
  Uri uri;
  bool _failure = false;
  bool _success = false;
  bool _failure1 = false;

  String paymentResponse;

  @override
  void initState() {
    super.initState();
    payeeAddress = "kodandapani.kanekal68@oksbi";
    payeeName = "kodandapani kanekal venkata";
    transactionNote = "Paid Food - IITDH Mess";
    amount = widget.value28;
    currencyUnit = "INR";

    uri = Uri.parse("upi://pay?pa=" +
        payeeAddress +
        "&pn=" +
        payeeName +
        "&tn=" +
        transactionNote +
        "&am=" +
        amount +
        "&cu=" +
        currencyUnit);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future launchTez(String item,int noofplates,String totcost,String user)async {
    String ifs;
    try {
      final String result = await platform.invokeMethod('launchUpi',<String,dynamic>{"url":uri.toString()});
      if(result.split('**')[0] == 'Success') {
        var route1 = new MaterialPageRoute(builder: (BuildContext context) =>
        new CircularIndicator(value: 'Please Wait',),
        );
        Navigator.of(context).push(route1);
        //print('This is ifs $ifs');
        if((await fetchPost(context, result.split('**')[1], item, noofplates, totcost, user)).contains('Message has been sent')){
          setState(() {
            _success = true;
            _failure = false;
            _failure1 = false;
          });
        }
        else{
          setState(() {
            _success = false;
            _failure = false;
            _failure1 = true;
          });
        }
      }
      else{
        setState(() {
          _failure = true;
        });
      }
      debugPrint("foooooooooool $result");
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String amounttopay = widget.value28;
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Payments page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100.0,
            ),
            _failure ?
            Container(
              height: 100.0,
              child: new Text('Payment Failed',
                  style: new TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.red)
              ),
            ):
                _success ?
                Container(
                  height: 100.0,
                  child: new Text('Order Successful',
                      style: new TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.green)
                  ),
                ) :
                    _failure1 ?
                    Container(
                      height: 100.0,
                      child: new Text('Status Pending.Check your orders after sometime.',
                          style: new TextStyle(fontSize: 18.0,fontStyle: FontStyle.italic,color: Colors.yellow)
                      ),
                    ) :
                    Container(
                      height: 30.0,
                    ),
            _failure ?
                new Container() :
            _failure1 ?
            new Container() :
            Container(
              //color: Colors.blue,
              child: new Text(
                'Order Summary',
                style: new TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
              )
            ),
            _failure ?
                new Container() :
            _failure1 ?
            new Container() :
            Container(
              height: 20.0,
            ),
            _failure ?
            new Container() :
            Container(
              //color: Colors.blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment : MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      // color: Colors.orange,
                        child: new Text(
                            'Items',
                            style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
                        )
                    ),
                    Container(
                      //color: Colors.blue,
                        child: new Text(
                            'Amount',
                            style: new TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
                        )
                    ),
                  ],
                )
            ),
            _failure ?
            new Container() :
            _failure1 ?
            new Container() :
            Container(
              height: 30.0,
            ),
            _failure ?
            new Container() :
            _failure1 ?
            new Container() :
            Container(
              //color: Colors.blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment : MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                     // color: Colors.orange,
                      child: new Text(
                        '${widget.items28.split('**')[0]}  x ${widget.counts28}',
                          style: new TextStyle(fontSize: 18.0,fontStyle: FontStyle.italic)
                      )
                    ),
                    Container(
                      //color: Colors.blue,
                      child: new Text(
                        '₹${widget.value28}',
    style: new TextStyle(fontSize: 17.0,fontStyle: FontStyle.italic)
                      )
                    ),
                  ],
                )
            ),
            _failure ?
            new Container() :
            _failure1 ?
            new Container() :
            Container(
              height: 100.0,
            ),

            _failure1 ?
            new Container() :
                _success ?
                new Container() :
            Container(
             // color: Colors.purple,
              child: new Center(
                child: new RaisedButton(
                  color: Colors.blue,
                  highlightColor: Colors.white,
                  splashColor: Colors.white,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: (() {
                    print('I am Launching ${widget.value28}');
                    launchTez(widget.items28.split('**')[0],widget.counts28,widget.value28,widget.user28);
                  }),
                  child: new Text(_failure ? 'Try to pay Rs.$amounttopay again' : 'Click to Pay Rs.$amounttopay/-',
                      style: new TextStyle(fontSize: 15.0,fontStyle: FontStyle.italic,color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}