import 'package:flutter/material.dart';
import 'fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'Payments.dart';
import 'ImagePick.dart';
import 'circular_indicator1.dart';
import 'login_page.dart';
import 'MenuEdit.dart';
import 'globals.dart' as globals;
import 'block.dart';

class MenuPage extends StatelessWidget {

  final String value;
  final String pass;

  MenuPage({Key key, this.value,this.pass}) : super (key: key);
  @override
  Widget build(BuildContext context) {

    final title = 'IITDH-Mess';
    //final double itemHeight = (size.height) / 5;
    //final double itemWidth = size.width / 5;
    return MaterialApp(

      title: title,
      home: MyHomePage(value1: value,pass1: pass,),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TapboxA extends StatefulWidget {
  final double iw,ih;
  final bool active1;
  final String user28;
  final String pass28;
  TapboxA({Key key,@required this.iw,@required this.ih,@required this.active1,@required this.user28,@required this.pass28}) : super(key: key);

  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = true;
  String items28;
  //final myController1 = TextEditingController();

  void _handleTap(){
    setState(() {
      _active = !_active;
    });
  }

  void _handleTap1(){
    setState(() {
      _active = true;
    });
  }

  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if(_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
   // myController1.dispose();
    super.dispose();
  }
  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 0));

    setState(() {
      _active = _active;
      _counter = 1;
    });

    return null;
  }
  //final double iw1,ih1;
  //_TapboxAState({Key key,this.iw1,this.ih1}) ;
  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: _getfuture(widget.user28,widget.pass28),
      onRefresh: _handleRefresh,
    );


  }

  FutureBuilder<String> _getfuture(String users1,String pass1){

      bool iscommit = false;

     var buildfut = new FutureBuilder(

        future: fetchPost(widget.active1,_counter,items28,widget.user28,widget.pass28),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return new Center(


              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  new CircularProgressIndicator(),
                  new Text('Loading'),
                ],
              ),


            );
          }
          else {
            String menu = snapshot.data;
            print("hello bro $menu");
            items28 = menu;
            List<String> menuList = menu.split("**");
            if(menuList.length >= 36){
              if(menuList[35] == '1'){
                iscommit = true;
                globals.isCommittee = true;
                //globals.Committee =
              }
              else{
                globals.isCommittee = false;
              }
            }
            if(menuList.length > 36){
              for(var i4 = 36; i4 < menuList.length;i4++){
                  globals.Committee = '${globals.Committee}**${menuList[i4]}';
              }
            }
            String payamount = '';
            var pay1 = int.tryParse(menuList[1]);
            if(pay1 != null) {
              payamount = (pay1 * _counter).toString();
            }

            if(menu == "No Connection"){
              return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      //shadowColor: Colors.lightBlueAccent.shade100,
                      //elevation: 5.0,
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Please connect to internet', style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 20.0,
                              color: Colors.red
                          )
                          ),
                          new Container(
                            height: 30.0,
                          ),
                      MaterialButton(
                        minWidth: 200.0,
                        height: 42.0,
                        onPressed: () {
                          _handleTap1();
                        },
                        color: Colors.lightBlueAccent,
                        child: Text('Retry', style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 20.0,
                            color: Colors.white
                        )
                        ),
                      ),
                      ]
                      ),
                    ),
                  ),
                );
            }

            return
              new Container(
                  decoration: new BoxDecoration(color: Colors.white),

                  child:
                  new Column(
                    //shrinkWrap: true,
                      children: <Widget>[
                        widget.active1 ?
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Text('Day',
                              style: TextStyle(fontStyle: FontStyle.italic,
                                  fontSize: 20.0,
                                  color: Colors.black),
                            ),
                            new Text('BreakFast',
                              style: TextStyle(fontStyle: FontStyle.italic,
                                  fontSize: 20.0,
                                  color: Colors.black),
                            ),
                            new Text('Lunch',
                              style: TextStyle(fontStyle: FontStyle.italic,
                                  fontSize: 20.0,
                                  color: Colors.black),
                            ),
                            new Text('Snacks',
                              style: TextStyle(fontStyle: FontStyle.italic,
                                  fontSize: 20.0,
                                  color: Colors.black),
                            ),
                            new Text('Dinner',
                              style: TextStyle(fontStyle: FontStyle.italic,
                                  fontSize: 20.0,
                                  color: Colors.black),
                            ),
                          ],
                        ) : new Expanded(child:
              GridView.count(

                crossAxisCount: 6,
                //childAspectRatio: ((widget.iw*(5/6)) / (widget.ih*(2/5))),
                // Generate 100 Widgets that display their index in the List
                children: List.generate(12, (index) {
                  return new GridTile(

                      child: new Card(
                       // color: Colors.lightBlueAccent,
                        child: FittedBox(
                          child:
                          index == 8 ?
                          new MaterialButton(
                            height: 10.0,
                            minWidth: 10.0,
                            // color: Theme.of(context).primaryColor,
                            //textColor: Colors.white,
                            child: new Icon(Icons.remove_circle),
                            onPressed: _decrementCounter,
                            // splashColor: Colors.redAccent,
                          ) :
                              index == 10 ?
                              new MaterialButton(
                                height: 10.0,
                                minWidth: 10.0,
                                // color: Theme.of(context).primaryColor,
                                //textColor: Colors.white,
                                child: new Icon(Icons.add_circle),
                                onPressed: _incrementCounter,
                                // splashColor: Colors.redAccent,
                              ) :
                          Text(
                            index == 0 ? 'Item' : index == 1 ? 'Cost' : index == 2 ? '' : index == 3 ? 'Quantity' : index == 4 ? '' : index == 5 ? 'Total\nCost' : index == 6 ? menuList[0] : index == 7 ? '₹${menuList[1]}' : index == 9 ? '$_counter' : index == 11 ? '₹$payamount': '1',
                            style: TextStyle(fontStyle: FontStyle.italic,
                                fontSize: 15.0,
                                color: Colors.black),
                            // style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20.0),

                          ),
                          fit: BoxFit.scaleDown,
                        ),

                      )
                  );
                }),
              ),
                        ),
                        new Expanded(child:
                            widget.active1 ?
                        GridView.count(
                          // Create a grid with 2 columns. If you change the scrollDirection to
                          // horizontal, this would produce 2 rows.

                          crossAxisCount: 5,
                          childAspectRatio: (widget.iw / widget.ih),
                          // Generate 100 Widgets that display their index in the List
                          children: List.generate(_active ? 5 : 35, (index) {
                            return new GridTile(

                                child: new Card(
                                  color: Colors.lightBlueAccent,
                                  child: FittedBox(
                                    child: Text(
                                      menuList[index],
                                      style: TextStyle(fontStyle: FontStyle.italic,
                                          fontSize: 20.0,
                                          color: Colors.black),
                                      // style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20.0),

                                    ),
                                    fit: BoxFit.scaleDown,
                                  ),

                                )
                            );
                          }),
                        ):
                            new Container(
                              margin: const EdgeInsets.all(10.0),
                              //color: const Color(0xFF00FF00),
                              width: 250.0,
                              height: 18.0,
                              child: Center(
                                child: new Container(
                                 // color: Colors.blue,
                                  width: 250.0,
                                  height: 68.0,
                                  child: Material(
         // color: Colors.orange,
                                  child: new InkWell(

                                    onTap: () => paymentpage(context,payamount,items28,_counter,users1),
         // highlightColor: Colors.blue,
                                    child: new Container(
                                      //width: 100.0,
                                      height: 50.0,
                                      decoration: new BoxDecoration(
                                        color: Colors.blueAccent,
                                        border: new Border.all(color: Colors.white, width: 2.0),
                                        borderRadius: new BorderRadius.circular(30.0),
                                      ),
                                      child: new Center(child: new Text('Proceed to pay ₹$payamount', style: new TextStyle(fontSize: 18.0, color: Colors.white),),),
                                    ),
                                  ),
                                  ),
                                ),
                              ),
                            ),
                        ),
                 widget.active1 ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(30.0),
                            shadowColor: Colors.lightBlueAccent.shade100,
                            elevation: 5.0,
                            child: MaterialButton(
                              minWidth: 200.0,
                              height: 42.0,
                              onPressed: () {
                                _handleTap();
                              },
                              color: Colors.lightBlueAccent,
                              child: Text(_active ? 'See Full Menu' : 'See Today Menu', style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20.0,
                                  color: Colors.white
                              )
                              ),
                            ),
                          ),
                        ) : new Container(),
                        widget.active1 ?
                        iscommit ?
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
                                var route3 = new MaterialPageRoute(builder: (BuildContext context) =>
                                new EditMenu(menu: menuList,user: users1,pass: pass1,),
                                );
                                Navigator.of(context).push(route3);
                              },
                              color: Colors.lightBlueAccent,
                              child: Text('Edit Menu', style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20.0,
                                  color: Colors.white
                              )
                              ),
                            ),
                          ),
                        ) : new Container()
                        :
                        new Container(),
                        widget.active1 ?
                        iscommit ?
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
                                var route4 = new MaterialPageRoute(builder: (BuildContext context) =>
                                new Block(user: users1,password: pass1,),
                                );
                                Navigator.of(context).push(route4);
                              },
                              color: Colors.lightBlueAccent,
                              child: Text('Block/UnBlock users', style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20.0,
                                  color: Colors.white
                              )
                              ),
                            ),
                          ),
                        ) : new Container()
                            :
                        new Container(),
                      ]
                  )
              );
          }
        });
     return buildfut;

  }



}

void paymentpage(BuildContext con,String payamount1,String items29,int counter28,String user) {
  var route = new MaterialPageRoute(builder: (BuildContext context) =>
  new UpiDemo(value28: payamount1,items28: items29,counts28: counter28,user28: user,),
  );
  if(int.parse(payamount1) == 0){
    Fluttertoast.showToast(
        msg: "Can't pay ₹0",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        bgcolor: "red",
        textcolor: "black"
    );
  }
  else {
    Navigator.of(con).push(route);
  }
}

class TapboxC extends StatefulWidget {
  final String value;
  final String pass28;
  TapboxC({Key key, this.value, this.pass28}) : super (key: key);
  @override
  _TapboxCState createState() => _TapboxCState();

}

class _TapboxCState extends State<TapboxC> {
  int votes = 0;
  Future<Null> voteup() async{
    await new Future.delayed(new Duration(seconds: 0));
    setState(() {
      votes++;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children : <Widget> [
              new RaisedButton(onPressed:() {_handlepres(context,widget.value,widget.pass28);},
                  child: new Text(globals.isCommittee ? 'Answer a query' :'Raise a query',style: TextStyle(color: Colors.white),),
                  highlightColor: Colors.white,
                  splashColor: Colors.white,
                  color: Colors.blue,
                  disabledColor: Colors.blue,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ),
              new RaisedButton(onPressed:() {_handlepres1(context,widget.value,widget.pass28);},
              child: new Text('See all queries',style: TextStyle(color: Colors.white),),
                highlightColor: Colors.white,
                splashColor: Colors.white,
                color: Colors.blue,
                disabledColor: Colors.blue,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ),
    ],
        ),
      ),
      onRefresh: voteup,
    );
  }

}

void _handlepres(BuildContext con,String username,String password) {
  var route = new MaterialPageRoute(builder: (BuildContext context) =>
  new ImagePick1(user: username,password: password,),
  );
  Navigator.of(con).push(route);
}

void _handlepres1(BuildContext con,String username,String password) {
  var route1 = new MaterialPageRoute(builder: (BuildContext context) =>
  new CircularIndicator1(value: 'Loading',user: username,password: password,),
  );
  Navigator.of(con).push(route1);
}

class MyHomePage extends StatelessWidget {
  final String value1;
  final String pass1;
  MyHomePage({Key key, this.value1, this.pass1}) : super (key: key);
  //TabController tabController;
  @override
  Widget build(BuildContext context) {
   // tabController = new TabController(length: 2, vsync: this);
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 5;
    print('Width of the screen');
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: new Text('Paid Food',
                style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15.0),
              ),),
              new Text('Menu',
                style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20.0),
              ),
              new Text('Complaints',
                style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15.0),
              ),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Welcome $value1"),
              GestureDetector(
                onTap: () {
                  logout(context);
                },
                child: new Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
        body: TabBarView(
            children: [
              TapboxA(iw: itemWidth,ih: itemHeight,active1: false,user28: value1,pass28: pass1,),
        TapboxA(iw: itemWidth,ih: itemHeight,active1: true,user28: value1,pass28: pass1,),

        TapboxC(value: value1,pass28: pass1,)
        ]
        ),
    ),
    );
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
Future<String> fetchPost(bool yes1,int counts,String items27,String user,String pass) async {
  // String e = Strings.concatAll(["hello", "world"]);
  if(counts == 1) {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        final response =

        await http.get(yes1
            ? 'http://35.186.156.206/menu.php?rollno=$user&password=$pass'
            : 'http://35.186.156.206/PaidItems.php?rollno=$user&password=$pass');


        if (response.statusCode == 200) {
          // If the call to the server was successful, parse the JSON

          print(response.body.toString());
          return response.body.toString();
        } else {
          return "False values fetched";
          // If that call was not successful, throw an error.


        }
      }
      else {
        Fluttertoast.showToast(
            msg: "No Internet Connection",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            bgcolor: "#e74c3c",
            textcolor: '#ffffff'
        );
        return "No Connection";
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          bgcolor: "#e74c3c",
          textcolor: '#ffffff'
      );
      return "No Connection";
    }
  }
  else{
    return items27;
  }
}
