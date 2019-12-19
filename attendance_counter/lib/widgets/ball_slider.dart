import 'package:flutter/material.dart';
import 'package:attendance_counter/widgets/slider.dart';

class BallSlider extends StatefulWidget {

  final int val;
  ValueChanged<int> valueChanged;

  BallSlider({@required this.val,@required this.valueChanged});

  @override
  _BallSliderState createState() => _BallSliderState();
}

class _BallSliderState extends State<BallSlider> {

  int value;

  @override
  void initState() {
    super.initState();
    value = widget.val;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right:16.0),
          child: Text("Absent"),
        ),
        Expanded(
            child: ThreePointSlider(
            onValueChanged: (v){
              value = v;
              widget.valueChanged(value);
            },
        )),
        Padding(
          padding: EdgeInsets.only(left:16.0),
          child: Text("Present"),
        )
      ],
    );
  }
}
