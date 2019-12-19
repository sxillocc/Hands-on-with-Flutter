import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bottom Sheet Example",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color appBarColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text("Bottom Sheet Example"),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
              child: Text("Change Theme Color"), onPressed: _onChangeName),
        ),
      ),
    );
  }

  void _onChangeName() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.close, color: appBarColor,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Choose new theme color',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: RaisedButton(
                                color: Colors.red,
                                textColor: Colors.white,
                                child: Text('Red'),
                                onPressed: () => setState(() {
                                      appBarColor = Colors.red;
                                      Navigator.pop(context);
                                    })),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: RaisedButton(
                                color: Colors.blueGrey,
                                textColor: Colors.white,
                                child: Text('Blue Grey'),
                                onPressed: () => setState(() {
                                      appBarColor = Colors.blueGrey;
                                      Navigator.pop(context);
                                    })),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: RaisedButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: Text('Blue'),
                                onPressed: () => setState(() {
                                      appBarColor = Colors.blue;
                                      Navigator.pop(context);
                                    })),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: RaisedButton(
                                color: Colors.green,
                                textColor: Colors.white,
                                child: Text('Green'),
                                onPressed: () => setState(() {
                                      appBarColor = Colors.green;
                                      Navigator.pop(context);
                                    })),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
