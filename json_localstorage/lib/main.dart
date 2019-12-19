import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:json_localstorage/subjects.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        title: Text("JSON and Local Storage"),
      ),
      body: Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
                .loadString('assets/test.json'),
          builder: (context,snapshot){
            if(snapshot.hasData){
              String json_string = snapshot.data.toString();
              Map<String,dynamic> m = json.decode(json_string);
              List<Subject> subjectList = List<Subject>();
              m['subjects'].forEach(
                  (subjectMap){
                    Subject subject = Subject.fromJson(subjectMap);
                    subjectList.add(subject);
                  }
              );
              List<Widget> widgetList = List<Widget>();
              subjectList.forEach((subjects){
                widgetList.add(Text("Subject Name = ${subjects.subName}"));
                widgetList.add(Text("No. of Presents = ${subjects.present}"));
                widgetList.add(Text("No. of Absents = ${subjects.absent}"));
                widgetList.add(Text("Criteria = ${subjects.criteria}"));
                widgetList.add(Text("Percentage = ${subjects.getPercent.toStringAsFixed(2)}"));
                widgetList.add(Divider(height: 16,));
              });
              return Container(
                child: Column(
                  children: widgetList,
                ),
              );
            }else{
              return CircularProgressIndicator();
            }
          }
        ),
      ),
    );
  }
}
