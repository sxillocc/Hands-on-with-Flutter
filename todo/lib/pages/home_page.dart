import 'package:flutter/material.dart';
import 'package:todo/widget_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.yellow[500],
              Colors.pink[500]
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter
          )
        ),
        child: Column(
          children: <Widget>[
            _drawAppBar(context),
            _drawProfile(context),
            _drawCardList(context),
          ],
        ),
      ),
    );
  }

  Widget _drawAppBar(BuildContext context){
    return Container(
      width: double.infinity,
      height: screenAwareSize(75, context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.menu,color: Colors.white,size: 28,),
          ),
          Text(
            "TODO",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search,color: Colors.white,size: 28,),
          )
        ],
      ),
    );
  }

  Widget _drawProfile(context){
    return Container(
      width: double.infinity,
      height: screenAwareSize(205, context),
      padding: EdgeInsets.symmetric(horizontal:screenAwareSize(36,context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 36.0),
            child: CircleAvatar(backgroundColor: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text("Hello, Jane", style: TextStyle(color: Colors.white,fontSize: 32),),
          ),
          Text("Looks like feel good.",style: TextStyle(color: Colors.white,fontSize: 16),),
          Text("You have 3 task to do today.",style: TextStyle(color: Colors.white,fontSize: 16),),
        ],
      ),
    );
  }

  Widget _drawCardList(BuildContext context){
    return Expanded(
        child: Container(
          margin: EdgeInsets.only(top: screenAwareSize(10, context),bottom: screenAwareSize(50, context),left: screenAwareSize(36, context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("TODAY : SEPTEMBER 12, 2019",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              Expanded(
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Text("temp_card_list"),
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
              )
            ],
          ),
          width: double.infinity,
        )
    );
  }
}
