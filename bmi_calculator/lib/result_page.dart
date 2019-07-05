import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/calculate.dart';

class ResultPage extends StatefulWidget {
  int weight;
  int height;

  ResultPage({this.weight,this.height, Key key}): super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  double get backButtonSize => ScreenAwareSize(52.0, context);
  String bmi;
  String maxWeight, minWeight;

  void initState(){
    super.initState();

    double bmiDouble = calculateBMI(height: widget.height,weight: widget.weight);
    bmi = bmiDouble.toStringAsFixed(1);

    maxWeight = maxWeightAtHeight(height: widget.height).toStringAsFixed(2);
    minWeight = minWeightAtHeight(height: widget.height).toStringAsFixed(2);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: <Widget>[
          _drawTitle(context),
          _drawResultCard(),
          _drawBottomMenu()
        ],
      ),
    );
  }

  Widget _drawTitle(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
        left: 24.0,
        top: ScreenAwareSize(72.0,context)
      ),
      child: Text(
        "BMI Calculator",
        style: new TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _drawResultCard(){
    double size = ScreenAwareSize(162, context);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenAwareSize(24.0, context)),
        child: Center(
          child: Card(
            color: Colors.indigo,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenAwareSize(12.0, context),
                vertical: ScreenAwareSize(48.0, context)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Your BMI",style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                    fontFamily: 'Raleway'
                  ),),
                  Container(
                    width: size,
                    height: size,
                    margin: EdgeInsets.symmetric(vertical: ScreenAwareSize(12.0, context)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("$bmi",style: TextStyle(fontSize: 48)),
                          Text("kg/m\u00B2",style: TextStyle(fontSize: 18,fontFamily: 'Raleway'),),
                        ],
                      ),
                    ),
                  ),
                  Text("Normal Weight at your height should be in Range $minWeight kg to $maxWeight kg",
                    style: TextStyle(fontSize: 18.0,color: Colors.white,fontFamily: 'Raleway'),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ),
      )
    );
  }

  Widget _drawBottomMenu(){
    return Container(
      height: ScreenAwareSize(108, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              height: backButtonSize,
              width: backButtonSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor
              ),
              child: Icon(Icons.arrow_back,color:Colors.white,size: 42),
            ),
          )
        ],
      ),
    );
  }

}