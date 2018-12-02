import 'package:flutter/material.dart';
import 'dart:async';
import 'globals.dart' as globals;

class chat extends StatefulWidget {
final String value;

chat({Key key, this.value}) : super (key: key);

_chatState createState() => new _chatState();

}

class _chatState extends State<chat> {
  ScrollController _controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 1500), () => _controller.jumpTo(_controller.position.maxScrollExtent));
    final body = new ListView.builder
    (
        controller: _controller,
      itemCount: widget.value.split('%%').length-1,
    itemBuilder: (BuildContext ctxt, int index) {
      return new Container(
        decoration: new BoxDecoration(
          color: globals.Committee.contains(widget.value.split('%%')[index].split('**')[0]) ? Colors.black12 : Colors.white,
          //shape: BoxShape.,
          border: new Border.all(
            color: Colors.black,
            width: 2.5,
          ),
        ),
        child: new Column(

          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Text(
                  globals.Committee.contains(widget.value.split('%%')[index].split('**')[0]) ? 'Posted by ${widget.value.split('%%')[index].split('**')[0]} (Mess Committee) :' : 'Posted by ${widget.value.split('%%')[index].split('**')[0]}  :',
                        style: TextStyle(color: Colors.green,fontSize: 15.0),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            new Text(
                '${widget.value.split('%%')[index].split('**')[1]}'
            ),
            new ListView.builder
            (
            itemCount: ((widget.value.split('%%')[index].split('**').length)-3),
    shrinkWrap: true,
                physics: ClampingScrollPhysics(),
    itemBuilder: (BuildContext ctxt, int index1)
      {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.network(
          'http://35.240.175.235/uploads/${widget.value.split('%%')[index].split('**')[index1+3]}',
        ),
      );
      }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                    '${widget.value.split('%%')[index].split('**')[2]}'
                ),
              ],
            ),
            new Divider(
              height: 20.0,
              color: Colors.blue[900],
            ),
            new Divider(
              height: 20.0,
              color: Colors.blue[900],
            ),
          ],
        ),
      );
    }
    );
    return Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('Complaints page'),
        leading: BackButton(
            color: Colors.white
        ),
      ),
      body: body,
    );
  }
}
