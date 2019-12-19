import 'package:flutter/material.dart';
import 'package:attendance_counter/widgets/atd_card.dart';
import 'package:attendance_counter/models/subjects.dart';
import 'dart:convert';
//import 'package:percent_indicator/percent_indicator.dart';
//import 'package:attendance_counter/test.json';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        textTheme: TextTheme(
          subtitle: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w300
                      ,fontSize: 18,color: Colors.red)
        )
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

  List<Widget> homeList;
  List<Subject> subjectList;

  @override
  void initState() {
    super.initState();
    subjectList = List<Subject>();
    homeList = <Widget>[
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Text(
          "Today",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Attendance Counter"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){},
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(10)
//          ),
          backgroundColor: Colors.black,
          icon: Icon(Icons.add),
          label: Text("EXTRA CLASS",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),)
      ),
      body: Container(
          padding: EdgeInsets.only(bottom: 8),
          alignment: Alignment.center,
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString("lib/test.json"),
            builder: (context,snapshot){

              if(snapshot.hasData){
                print("fetched");

                String json_string = snapshot.data.toString();
                Map<String, dynamic> parsedJson = json.decode(json_string);

                parsedJson['subjects'].forEach(
                    (subjectJson){
                      Subject s = Subject.fromJson(subjectJson);
                      homeList.add(
                          SubjectCard(subject: s,)
                      );
                    }
                );
                return ListView(
                  children: homeList
                );
              }else{
                return CircularProgressIndicator();
              }

            },
          )

      )
    );
  }
}

class SubjectCard extends StatelessWidget {

  Subject subject;

  SubjectCard({@required this.subject});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0,8,8,0),
      child: AtdCard(
        subject: subject.subName,
        criteria:subject.criteria,
        percent: subject.getPercent,
        v: 0,
        onValueChange: (v){},
      ),
    );
  }
}