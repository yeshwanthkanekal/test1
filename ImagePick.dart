import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'circular_indicator.dart';
import 'fluttertoast.dart';
import 'menupage.dart';

class ImagePick1 extends StatelessWidget {
  final String user;
  final String password;
  ImagePick1({Key key, this.user, this.password}) : super (key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Query page',users: user,pass1: password,),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String users;
  final String pass1;
  MyHomePage({Key key, this.title, this.users, this.pass1}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File> _imageFile = new List(20);
  //Future<File> _image1;
  File _image2;
  int _counter = 0;
  final myController = TextEditingController();
  //final String users = widget.users;

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void uploads(List<File> imageFiles,String uploadtext,BuildContext context,String user,String pass) async {
    var stream;
    //var value1;
    var length;
    var multipartFile;
    var uri = Uri.parse("http://35.186.156.206/storechat.php");
    var request = new http.MultipartRequest("POST", uri);
    for (int i = 0; i < _counter; i++) {
      stream = new http.ByteStream(DelegatingStream.typed(imageFiles[i].openRead()));
      length = await imageFiles[i].length();
      multipartFile = new http.MultipartFile(
          'image$i', stream, length, filename: basename(imageFiles[i].path));
      request.files.add(multipartFile);
    }
    request.fields['title'] = uploadtext;
    request.fields['counter'] = _counter.toString();
    request.fields['user'] = widget.users;
    request.fields['password'] = pass;
    request.fields['rollno'] = user;
    //print('This is password $user');
    request.fields['timestamp'] = '${new DateTime.now()}';

    var response = await request.send();

    if(response.statusCode == 200){
      print("Image uploaded");
      print(response.contentLength);
      response.stream.transform(utf8.decoder).listen((value) {
        if(value == 'yes'){
          print("I am here");
          Fluttertoast.showToast(
              msg: "Successfully submitted query",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              bgcolor: "green",
              textcolor: "black"
          );
          Navigator.of(context).pop();
          myController.text = '';
        }
        else{
          Fluttertoast.showToast(
              msg: "query submission failed",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              bgcolor: "red",
              textcolor: "white"
          );
          Navigator.of(context).pop();
        }
        print(value);
        //value1 = value;
      });

    }
    else{
      print("Upload Failed");
    }

  }

  Future _onImageButtonPressed(ImageSource gallery) async {

    return ImagePicker.pickImage(source: gallery);

  }

  void _onImageButtonPressed1(){
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new WillPopScope(
      onWillPop: () {
        var route = new MaterialPageRoute(builder: (BuildContext context) =>
        new MenuPage(value: widget.users,pass: widget.pass1,),
        );
        //Navigator.of(context).pop();
        Navigator.of(context).push(route);
      },
      child: new Scaffold(
          appBar: new AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: new Text(widget.title),
            leading: BackButton(
                color: Colors.white
            ),
          ),
          body:

          new ListView.builder
            (
              itemCount: _counter+3,
              itemBuilder: (BuildContext ctxt, int index) {
                if(index == 0){
                  return Container(
                    child: new ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 300.0,
                      ),
                      child: new Scrollbar(
                        child: new SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: new Theme(
                            data: new ThemeData(
                              primaryColor: Colors.green,
                              primaryColorDark: Colors.green,
                              hintColor: Colors.green,
                            ),
                            child: new TextField(
                              controller: myController,
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.green)),
                                hintText: 'Enter your query here',
                              ),
                              maxLines: null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                else if(index == 1){
                  return new Container(
                    alignment: Alignment.center,
                    child:
                    ButtonTheme(
                      minWidth: 30.0,
                      height: 40.0,
                      child: new RaisedButton(
                          textColor: Colors.white,
                          disabledColor: Colors.blue,
                          color: Colors.blue,
                          highlightColor: Colors.lightGreenAccent,
                          splashColor: Colors.lightGreenAccent,
                          onPressed: () async{
                            _image2 = await _onImageButtonPressed(ImageSource.gallery);
                            if(_image2 != null) {
                              print('This is image $_image2');
                              _imageFile[_counter] = _image2;
                              _onImageButtonPressed1();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Text('Click me to attach an image',
                                style: TextStyle(color: Colors.white,fontSize: 16.0),
                              ),
                              const Icon(Icons.photo_library),
                            ],
                          ),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                      ),
                    ),
                  );
                }
                else if(index == 2){
                  return new Container(
                    alignment: Alignment.center,
                    //color: Colors.blue,
                    child: new RaisedButton(
                        textColor: Colors.white,
                        disabledColor: Colors.blue,
                        color: Colors.blue,
                        highlightColor: Colors.lightGreenAccent,
                        splashColor: Colors.lightGreenAccent,
                        child: new Text("Submit query",
                          style: TextStyle(color: Colors.white,fontSize: 16.0),
                        ),
                        onPressed:(){
                          uploads(_imageFile,myController.text,context,widget.users,widget.pass1);
                          var route1 = new MaterialPageRoute(builder: (BuildContext context) =>
                          new CircularIndicator(value: 'Posting query',),
                          );
                          Navigator.of(context).push(route1);},
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                    ),
                  );
                }
                else{
                  return Image.file(_imageFile[index-3]);
                }
                //return _previewImage(index);
              }
          )
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}


