import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seat_availability/models/trains.dart';
import 'package:seat_availability/widgets/train_number.dart';
import 'package:seat_availability/widgets/date.dart';
import 'package:seat_availability/widgets/drop_list.dart';

void main(){
  runApp(MyApp());
  // getTrain();
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
  String trainNumber, date,from,to,quota,trainClass;
  List<String> quotaList = List<String>();
  List<String> trainClassList = List<String>();

  void initState(){
    super.initState();
    trainNumber = "";
    date = "";
    from = "";
    to = "";
    quota = "General";
    trainClass = "SL (Sleeper)";
    quotaList.add("General");
    quotaList.add("Ladies");
    trainClassList.add("SL (Sleeper)");
    trainClassList.add("1A (First AC)");
    trainClassList.add("2A (Second AC)");
    trainClassList.add("3A (Third AC)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seatbility"),),
      body: _drawHome(),
    );
  }

  Widget _drawHome(){
    return Container(
      child: Column(
        children: <Widget>[
          _drawInputs(),
          Expanded(child: _drawTrains(),)
        ],
      ),
    );
  }
  Widget _drawInputs(){
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 8,),
          Row(
            children: <Widget>[
              Expanded(
                child: TrainNumber(
                  onChanged: (val) => trainNumber = val,
                )
              ),
              SizedBox(width: 8,),
              Expanded(child: DatePicker())
            ],
          ),
          SizedBox(height: 8,),
          Row(
            children: <Widget>[
              Expanded(child: DropList(title: "Quota",onChanged: (val)=>quota=val,item: quotaList,),),
              SizedBox(width: 8,),
              Expanded(child: DropList(title: "Class",onChanged: (val)=>trainClass=val,item: trainClassList,))
            ],
          ),
          SizedBox(height: 8,),
          _drawButton(title: "From Station",icon: Icons.trip_origin),
          SizedBox(height: 8,),
          _drawButton(title: "To Station",icon: Icons.place),
          SizedBox(height: 8,),
          RaisedButton(
            child: Text("Check Now",style: TextStyle(color: Colors.white),),
            onPressed: (){},
            color: Colors.blue[900],
          ),
        ],
      )
    );
  }
  Widget _drawTrains(){
    return Container();
  }

  Widget _drawButton({String title, IconData icon}){
    return 
      Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0)
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(icon),
                ),
                Text(title)
              ],    
            ),
      );
  }
}


Future<TrainInfo> getTrain() async{
  String rootJsonTrain = await rootBundle.loadString("lib/test_json/train.json");
  Map jsonMap = jsonDecode(rootJsonTrain);
  if(jsonMap['response_code'] == 200){
    TrainInfo trainInfo = TrainInfo.fromJson(jsonMap);
    return trainInfo;
  }
  else
    throw Exception("data not fetched");
}