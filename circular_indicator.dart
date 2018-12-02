import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  String value;

  CircularIndicator({Key key, this.value}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final body = new Center(


      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          new CircularProgressIndicator(),
          new Text(value),
        ],
      ),


    );
    return Scaffold(
      body: body,
    );
  }
}
