import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'BlockMain.dart';
import 'circular_indicator.dart';
import 'fluttertoast.dart';
import 'unblock.dart';
import 'login_page.dart';

class Block extends StatelessWidget {

  final String user;
  final String password;

  Block({Key key,@required this.user,@required this.password}) : super (key: key);

  @override
  Widget build(BuildContext context) {

    final body = Center(
      child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new RaisedButton(onPressed:() {
              var route = new MaterialPageRoute(builder: (BuildContext context) =>
              new Block1(user: user,password: password,),
              );
              Navigator.of(context).push(route);
            },
                child: new Text('Block a user',style: TextStyle(color: Colors.white),),
                highlightColor: Colors.white,
                splashColor: Colors.white,
                color: Colors.blue,
                disabledColor: Colors.blue,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),
            new RaisedButton(onPressed:() {
              fetchPost(context, user, password);
              var route1 = new MaterialPageRoute(builder: (BuildContext context) =>
              new CircularIndicator(value: 'Loading',),
              );
              Navigator.of(context).push(route1);
            },
                child: new Text('Unblock a user',style: TextStyle(color: Colors.white),),
                highlightColor: Colors.white,
                splashColor: Colors.white,
                color: Colors.blue,
                disabledColor: Colors.blue,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text('Mess Committee'),
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
      body: body,
    );
  }

}

Future<String> fetchPost(BuildContext context,String rollno,String pass) async {
  // String e = Strings.concatAll(["hello", "world"]);

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      final response =
      await http.get('http://35.186.156.206/unblock.php?rollno=$rollno&password=$pass');

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        if(response.body.toString() == 'no'){
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Contact Mess Committee",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              bgcolor: "red",
              textcolor: 'white'
          );
          return 'no';
        }
        var route = new MaterialPageRoute(builder: (BuildContext context) =>
        new unBlock1(user: rollno,password: pass,busers: response.body.toString(),),
        );
        Navigator.of(context).pop();
        Navigator.of(context).push(route);
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