import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'circular_indicator.dart';
import 'fluttertoast.dart';
import 'login_page.dart';

class Block1 extends StatefulWidget {

  final String user;
  final String password;

  Block1({Key key,@required this.user,@required this.password}) : super (key: key);

  _Block1State createState() => new _Block1State();

}

class _Block1State extends State<Block1> {

  final myController1 = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    myController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text('Block User'),
              GestureDetector(
                onTap: () {
                  logout(context);
                },
                child: new Icon(Icons.exit_to_app),
              ),
            ],
          ),
          leading: BackButton(
              color: Colors.white
          ),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                controller: myController1,
                //initialValue: 'alucard@gmail.com',
                decoration: InputDecoration(
                  hintText: 'Enter RollNo.',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: Colors.lightBlueAccent.shade100,
                  elevation: 5.0,
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 42.0,
                    onPressed: () {
                      //print('yeshwanth ${myController1.text}');
                      fetchPost(context,myController1.text,widget.user,widget.password);
                      var route1 = new MaterialPageRoute(builder: (BuildContext context) =>
                      new CircularIndicator(value: 'Validating Credentials',),
                      );
                      Navigator.of(context).push(route1);
                    },
                    color: Colors.lightBlueAccent,
                    child: Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

}

Future<String> fetchPost(BuildContext context,String rollno1,String rollno,String pass) async {
  // String e = Strings.concatAll(["hello", "world"]);

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      final response =
      await http.get('http://35.186.156.206/block.php?rollno=$rollno&password=$pass&rollno1=$rollno1');

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        if(response.body.toString() == 'yes'){
          Fluttertoast.showToast(
              msg: "Successfully Blocked",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              bgcolor: "green",
              textcolor: 'black'
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          return 'yes';
        };
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Network error or Invalid Details",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            bgcolor: "red",
            textcolor: 'white'
        );
        return 'no';
        //return response.body.toString();
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
      return 'no1';
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
    return 'no1';
  }

}

logout(BuildContext context) {
  var route = new MaterialPageRoute(builder: (BuildContext context) =>
  new LoginPage(),
  );
  Fluttertoast.showToast(
      msg: "Logged out Successfully",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      bgcolor: "green",
      textcolor: "black"
  );
  Navigator.of(context).push(route);
}