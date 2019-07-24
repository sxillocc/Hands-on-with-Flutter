import 'package:flutter/material.dart';
import 'package:range_slider/widgets/range_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
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
        title: Text("Range Slider"),
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal:8.0),
            child: FancyRangeSlider(),
        ),
      ),
    );
  }
}
