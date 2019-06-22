import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TouchPage(),
      theme: ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.red,
        fontFamily: 'Raleway'
      ),
      title: "Gestures Cookbook",
    );
  }
}

class TouchPage extends StatefulWidget {
  @override
  _TouchPageState createState() => _TouchPageState();
}

class _TouchPageState extends State<TouchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ripple Flat Button"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Flat Button made with Container which Ripple on touch",
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w100,fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: new FlatContainerButton(),
            ),
            Container(
              padding: const EdgeInsets.only(top: 80.0),
              child: RaisedButton(        
                child:Text(
                  "Next",
                  style: TextStyle(color: Colors.white,fontSize: 18.0,)
                ),
                color: Colors.green,
                onPressed: (){

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FlatContainerButton extends StatelessWidget {
  const FlatContainerButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Flat Button",
          style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18.0),
        ),
      ),
      onTap: (){
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Button Tapped"),)
        );
      },
    );
  }
}