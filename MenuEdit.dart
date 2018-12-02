import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'circular_indicator.dart';
import 'fluttertoast.dart';
import 'login_page.dart';

class EditMenu extends StatefulWidget {
  final List<String> menu;
  final String user;
  final String pass;
  EditMenu({Key key,@required this.menu,@required this.user,@required this.pass}) : super (key: key);

  _EditMenuState createState() => new _EditMenuState();

}

class _EditMenuState extends State<EditMenu> {
  var textEditingControllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    for(var i = 0; i < 35;i++){
      var textEditingController = new TextEditingController(text: widget.menu[i]);
      textEditingControllers.add(textEditingController);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for(var i = 0; i < 35;i++){
      textEditingControllers[i].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double ih = (size.height) / 2;
    final double iw = size.width / 5;
    return Scaffold(
        appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text('Menu Edit Page'),
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
      color: Colors.black,
      child: new Column(
        children: <Widget>[
          new Expanded(child:
          GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this would produce 2 rows.

            crossAxisCount: 5,
            childAspectRatio: (iw / ih),
            // Generate 100 Widgets that display their index in the List
            children: List.generate(35, (index) {
              return new Card(

                  child:
                  TextFormField(
                    style: index%5 == 0 ? new TextStyle(color: Colors.blue) : new TextStyle(color: Colors.black),
                    keyboardType: TextInputType.multiline,
                    maxLines: 50,
                        autofocus: false,
                        enabled: index%5 == 0 ? false : true,
                        controller: textEditingControllers[index],
                      ),
              );
            }),
          )
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Colors.white,
              elevation: 5.0,
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                onPressed: () {
                  fetchPost(textEditingControllers,context,widget.user,widget.pass);
                  var route1 = new MaterialPageRoute(builder: (BuildContext context) =>
                  new CircularIndicator(value: 'Changing Menu',),
                  );
                  Navigator.of(context).push(route1);
                },
                color: Colors.white,
                child: Text('Submit', style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                    color: Colors.black
                )
                ),
              ),
            ),
          )
        ],
      ),
    )
    );
  }
}

Future<String> fetchPost(List<TextEditingController> textcontrol,BuildContext context,String users,String pass1) async {
  // String e = Strings.concatAll(["hello", "world"]);

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      var uri = Uri.parse("http://35.186.156.206/ChangeMenu.php");
      var request = new http.MultipartRequest("POST", uri);
      for(var i = 0; i < 35;i++) {
        request.fields['item$i'] = textcontrol[i].text;
      }
      request.fields['rollno'] = users;
      request.fields['password'] = pass1;
      var response = await request.send();

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Successfully changed Menu",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              bgcolor: "green",
              textcolor: "black"
          );
          return 'yes';
        //return response.body.toString();
      } else {

        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    }
    else{
      //Navigator.of(context).pop();

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
    //Navigator.of(context).pop();

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