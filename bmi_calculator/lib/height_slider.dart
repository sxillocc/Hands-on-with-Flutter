import 'package:flutter/material.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:bmi_calculator/height_style.dart';

class HeightSlider extends StatelessWidget {
  final int height;

  const HeightSlider({this.height, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SliderLabel(height: height),
          Row(
            children: <Widget>[
              SliderCircle(),
              Expanded(child: SliderLine(),)
            ],
          )
        ],
      ),
    );
  }
}

class SliderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
        40,(index)=>
          Expanded(
            child: Container(
              height: 2.0,
              decoration: BoxDecoration(
                color: index.isEven 
                     ? Colors.blue
                     : Colors.white 
              ),
            ),
          )
         
      ),
    );
  }
}

class SliderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSizeAdapted(context),
      height: circleSizeAdapted(context),
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle
      ),
      child: Icon(
        Icons.unfold_more,
        color: Colors.white,
        size: 0.6 * circleSizeAdapted(context),
      ),
    );
  }
}

class SliderLabel extends StatelessWidget {
  final int height;

  SliderLabel({this.height, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double circlePaddingLeft = circleSizeAdapted(context) - 2 * labelsFontSize  - 3;
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          left: circlePaddingLeft,
        ),
        child: Text(
          "$height",
          style: TextStyle(fontSize: labelsFontSize,color: Colors.blue, fontWeight: FontWeight.w600),
        ),
      )
    );
  }
}