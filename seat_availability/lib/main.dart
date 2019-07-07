import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seat_availability/models/trains.dart';

void main(){
  runApp(MyApp());
  getTrainInfo();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seatbility',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seatbility"),),
      
    );
  }
}

Future<String> loadTestJsonTrain() async {
  return await rootBundle.loadString("lib/test_json/train.json");
}

Future<Train> getTrain() async{
  String rootJsonTrain = await loadTestJsonTrain();
  // print(rootJsonTrain);
  return Train.fromJson(jsonDecode(rootJsonTrain));
}