import 'package:flutter/material.dart';
import 'package:attendance_counter/widgets/ball_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.pink,
        textTheme: TextTheme(
          subtitle: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w300
                      ,fontSize: 18,color: Colors.red)
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Attendance Counter"),
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            height: 160,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
//              color: Colors.black,
              border: Border.all(),
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:EdgeInsets.fromLTRB(4,4,4,2),
                                child: Text(
                                  'Object Oriented System Design',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding:EdgeInsets.fromLTRB(4,2,4,4),
                                  child: Text(
                                    'You have to attend 5 classes in a row',
                                    style: Theme.of(context).textTheme.subtitle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
//                        color: Colors.red,
                      )
                    ],
                  ),

                ),
                Padding(
                  padding:EdgeInsets.fromLTRB(4,0,4,0),
                  child: BallSlider(),
                ),
              ],
            ),
          )
      ),
    );
  }
}

