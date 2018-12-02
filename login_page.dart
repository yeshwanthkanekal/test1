import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'menupage.dart';
import 'circular_indicator.dart';
import 'fluttertoast.dart';
import 'forgotPass.dart';
import 'changePass.dart';

Future<String> fetchPost(BuildContext context,String ones,String twos,TextEditingController con1,TextEditingController con) async {
 // String e = Strings.concatAll(["hello", "world"]);

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      final response =
      await http.get('http://35.186.156.206/index.php?rollno=${ones}&password=${twos}');

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        if(response.body.toString() == "yes"){
          con.text = "";
          con1.text = "";
          var route = new MaterialPageRoute(builder: (BuildContext context) =>
          new MenuPage(value: ones,pass: twos,),
          );
          Navigator.of(context).pop();
          Navigator.of(context).push(route);
          Fluttertoast.showToast(
              msg: "Logged In Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              bgcolor: "green",
              textcolor: "black"
          );
        }
        else{
          if(response.body.toString() == "blocked"){
            Navigator.of(context).pop();
            Fluttertoast.showToast(
                msg: "Your account is blocked",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                bgcolor: "#e74c3c",
                textcolor: '#ffffff'
            );
          }
          else {
            Navigator.of(context).pop();
            Fluttertoast.showToast(
                msg: "Wrong Username or Password",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                bgcolor: "#e74c3c",
                textcolor: '#ffffff'
            );
          }
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

}

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final myController = TextEditingController();
  final myController1 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    myController1.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: new ClipRRect(
          borderRadius: new BorderRadius.circular(38.0),
          child: Image.asset('images/mess1.png'),
        ),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: myController1,
      //initialValue: 'alucard@gmail.com',
      decoration: InputDecoration(
        hintText: 'Roll No',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      //initialValue: 'some password',
      obscureText: true,
      controller: myController,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            fetchPost(context,myController1.text,myController.text,myController1,myController);
            var route1 = new MaterialPageRoute(builder: (BuildContext context) =>
            new CircularIndicator(value: 'Verifying user',),
            );
            Navigator.of(context).push(route1);
           // Navigator.of(context).pushNamed(HomePage.tag);
          },
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        forgotPass(context);
      },
    );

    final changeLabel = FlatButton(
      child: Text(
        'Change password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        ChangePass(context);
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel,
            changeLabel
          ],
        ),
      ),
    );
  }
}

void forgotPass(BuildContext context) {
  var route = new MaterialPageRoute(builder: (BuildContext context) =>
  new ForgotPassword(),
  );
  //Navigator.of(context).pop();
  Navigator.of(context).push(route);
}

void ChangePass(BuildContext context) {
  var route = new MaterialPageRoute(builder: (BuildContext context) =>
  new ChangePassword(),
  );
  //Navigator.of(context).pop();
  Navigator.of(context).push(route);
}