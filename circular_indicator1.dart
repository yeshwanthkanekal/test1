import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'fluttertoast.dart';
import 'chat.dart';

Future<String> fetchPost(BuildContext context,String users,String pass) async {
  // String e = Strings.concatAll(["hello", "world"]);

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      final response =
      await http.get('http://35.186.156.206/GetChat.php?rollno=$users&password=$pass');

      if (response.statusCode == 200) {
        var route = new MaterialPageRoute(builder: (BuildContext context) =>
        new chat(value: response.body.toString()),
        );
        Navigator.of(context).pop();
        Navigator.of(context).push(route);
        Fluttertoast.showToast(
            msg: "Successfully loaded",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            bgcolor: "green",
            textcolor: 'black'
        );
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

class CircularIndicator1 extends StatefulWidget {
  final String value;
  final String user;
  final String password;
  CircularIndicator1({Key key, this.value, this.user, this.password}) : super (key: key);

  _CircularIndicatorState createState() => new _CircularIndicatorState();

}

class _CircularIndicatorState extends State<CircularIndicator1> {

  @override
  void initState() {
    super.initState();
    fetchPost(context,widget.user,widget.password);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final body = new Center(


      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          new CircularProgressIndicator(),
          new Text(widget.value),
        ],
      ),


    );
    return Scaffold(
      body: body,
    );
  }
}