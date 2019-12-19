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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bottom Sheet Example"),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
              child: Text("Change your Name"), onPressed: _onChangeName),
        ),
      ),
    );
  }

  void _onChangeName() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                    color: Colors.red,
                  ),
                  Container(
                    height: 40,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 40,
                    color: Colors.green,
                  )
                ],
              ),
            ),
          );
        });
  }
}


//class HomeView extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        leading: Icon(Icons.details),
//        title: Text('Bottom Sheet Demo'),
//      ),
//      floatingActionButton: MyFloatingActionButton(),
//      body: Center(
//        child: Text('HomeView'),
//      ),
//    );
//  }
//}
//class MyFloatingActionButton extends StatefulWidget {
//  @override
//  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
//}
//
//class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
//
//  bool showFab = true;
//
//  @override
//  Widget build(BuildContext context) {
//    return showFab ? FloatingActionButton(
//        onPressed: (){
//          var bottomSheetController = showBottomSheet(
//              context: context,
//              builder: (context){
//                return FractionallySizedBox(
//                    heightFactor: 0.5,
//                    child: BottomSheetWidget(),
//                );
//              },
//              elevation: 15
//          );
//          showFAB(false);
//          bottomSheetController.closed.then((value){
//            showFAB(true);
//          });
//        }
//    ) :
//    Container();
//  }
//
//  void showFAB(bool showButton){
//    setState(() {
//      showFab = showButton;
//    });
//  }
//}
//
//class BottomSheetWidget extends StatefulWidget {
//  @override
//  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
//}
//
//class _BottomSheetWidgetState extends State<BottomSheetWidget> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
//      height: 160,
//      decoration: BoxDecoration(
//        color: Colors.blue,
//        border: Border.all(
//          color: Colors.blue
//        )
//      ),
//      child: Column(
//        mainAxisSize: MainAxisSize.max,
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Container(
//            height: 50,
//            decoration: BoxDecoration(
//              color: Colors.blueGrey[300],
//              borderRadius: BorderRadius.circular(10)
//            ),
//            alignment: Alignment.center,
//            margin: const EdgeInsets.all(10),
//            padding: const EdgeInsets.all(10),
//            child: TextField(
//              decoration: InputDecoration.collapsed(hintText: 'Enter your name'),
//            ),
//          ),
//          SheetButton()
//        ],
//      ),
//    );
//  }
//}
//
//class SheetButton extends StatefulWidget {
//  _SheetButtonState createState() => _SheetButtonState();
//}
//class _SheetButtonState extends State<SheetButton> {
//  bool checkingFlight = false;
//  bool success = false;
//  @override
//  Widget build(BuildContext context) {
//    return !checkingFlight
//        ? MaterialButton(
//      color: Colors.grey[800],
//      onPressed: () {
//      },
//      child: Text(
//        'Check Flight',
//        style: TextStyle(color: Colors.white),
//      ),
//    )
//        : !success
//        ? CircularProgressIndicator()
//        : Icon(
//      Icons.check,
//      color: Colors.green,
//    );
//  }
//}
