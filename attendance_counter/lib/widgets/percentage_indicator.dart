import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RoundPercentPie extends StatelessWidget {
  final double percent;
  final Color backgroundColor;
  final Color progressColor;

  RoundPercentPie({this.percent,this.backgroundColor,this.progressColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor
      ),
      child: Center(
        child: CircularPercentIndicator(
          radius: 90.0,
          backgroundColor: backgroundColor,
          progressColor: progressColor,
          percent: percent,
          center: Text("${(percent*100).toStringAsFixed(1)}%",style: TextStyle(fontSize: 22,color: progressColor),),
          arcType: ArcType.FULL,
          arcBackgroundColor: backgroundColor,
        ),
      ),
//                        color: Colors.red,
    );
  }
}
