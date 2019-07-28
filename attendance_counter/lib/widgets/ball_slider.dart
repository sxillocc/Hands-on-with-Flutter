import 'package:flutter/material.dart';
import 'package:attendance_counter/widgets/slider.dart';

class BallSlider extends StatelessWidget {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right:4.0),
          child: Text("Absent"),
        ),
        Expanded(
            child: ThreePointSlider(
            onValueChanged: (v){
              value = v;
            },
        )),
        Padding(
          padding: EdgeInsets.only(left:4.0),
          child: Text("Present"),
        )
      ],
    );
  }
}
