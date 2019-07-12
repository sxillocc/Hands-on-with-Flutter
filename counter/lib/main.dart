import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.purple[900],
        primaryColor: Colors.purple
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              child: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pink[500],
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                        ),
                        child: Center(
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Till Now you're at",style: TextStyle(fontSize: 20,color: Colors.white),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: 45,
                                      alignment: Alignment.center,
                                      child: Text("$count",style: TextStyle(fontSize: 36,color: Colors.white),)
                                  ),
                                  Text(" counts",style: TextStyle(fontSize: 20,color: Colors.white),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            padding: EdgeInsets.fromLTRB(4,4,12,4),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 6.0),
                                  child: Icon(Icons.add_circle_outline,color: Colors.white,),
                                ),
                                Text("INCREASE",style: TextStyle(color: Colors.white),),
                              ],
                            ),
                            onPressed: (){
                              setState(() {
                                count = count + 1;
                              });
                            },
                            color: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          RaisedButton(
                            padding: EdgeInsets.fromLTRB(12,4,4,4),
                            child: Row(
                              children: <Widget>[
                                Text("DECREASE",style: TextStyle(color: Colors.white),),
                                Padding(
                                  padding: EdgeInsets.only(left: 6.0),
                                  child: Icon(Icons.remove_circle_outline,color: Colors.white,),
                                ),
                              ],
                            ),
                            onPressed: (){
                              setState(() {
                                count = count - 1;
                              });
                            },
                            color: Colors.red,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
