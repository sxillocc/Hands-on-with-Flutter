import 'package:flutter/material.dart';
import 'dart:math' as math;

class ThreePointSlider extends StatefulWidget {
  ValueChanged<int> onValueChanged;
  ThreePointSlider({this.onValueChanged});
  @override
  _ThreePointSliderState createState() => _ThreePointSliderState();
}

class _ThreePointSliderState extends State<ThreePointSlider> {
  double position = 0;
  bool initial = true;
  double sliderWidth = 0;
  double sliderHeight = 0;
  double get checkPoint1 => sliderWidth/3;
  double get checkPoint2 => 2*sliderWidth / 3;
  double get middlePosition => sliderWidth/2 - 10;
  double get minPosition => 0;
  double get maxPosition => sliderWidth - 20;
  Color color = Colors.white;
  Color ballColor = Colors.blueGrey;
  Color helperColor = Colors.black;
  int value = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.0),
        color: color,
      ),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16,4,16,4),
      child: LayoutBuilder(
          builder: (context,constraints){
            List<Widget> dotList = List.generate(3, (i){
              return dots(size:10,color: helperColor,);
            });
            sliderWidth = constraints.maxWidth;
            sliderHeight = constraints.maxHeight;
            position = initial ? middlePosition : position;
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: sliderWidth,
                  height: 3,
                  color: helperColor,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: dotList,
                ),
                Opacity(
                  opacity: 0,
                  child: Container(
                    width: sliderWidth,
                    height: sliderHeight,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: traverseStart,
                          child: Container(
                            width: sliderWidth/3,
                            height: sliderHeight,
                            color: Colors.red,
                          ),
                        ),
                        GestureDetector(
                          onTap: traverseMiddle,
                          child: Container(
                            width: sliderWidth/3,
                            height: sliderHeight,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: traverseEnd,
                          child: Container(
                            width: sliderWidth/3,
                            height: sliderHeight,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: position,
                  child: GestureDetector(
                    onHorizontalDragEnd: onHzDragEnd,
                    onHorizontalDragUpdate: onHzDragUpdate,
                    child: dots(size: 20,color: ballColor,),
                  ),
                ),
              ],
            );
          }
      )
    );
  }
  void onHzDragUpdate(DragUpdateDetails details){
    Offset offsetDelta = details.delta;
    double xComponent = offsetDelta.dx;
    setState(() {
      initial = false;
      position += xComponent;
      position = normalizePosition(position);
      setColor(position);
    });
  }

  void onHzDragEnd(DragEndDetails details){
    bool isPresent = position + 10 > checkPoint2;
    bool isEmpty = position + 10 <= checkPoint2 &&
                  position + 10 > checkPoint1;
    bool isAbsent = position + 10 <=checkPoint1;

    if(isPresent) traverseEnd();
      else if(isEmpty) traverseMiddle();
        else if(isAbsent) traverseStart();

  }

  void setColor(double position){
    setState(() {
      if(position == maxPosition){
        color = Colors.green;
        ballColor = Colors.green[900];
        helperColor = Colors.white;
        value = 2;
        widget.onValueChanged;
      }else if(position == minPosition){
        color = Colors.red;
        ballColor = Colors.red[900];
        helperColor = Colors.white;
        value = 0;
        widget.onValueChanged;
      }else if(position == middlePosition){
        color = Colors.white;
        ballColor = Colors.blueGrey;
        helperColor = Colors.black;
        value = 1;
        widget.onValueChanged;
      }
    });
  }

  double normalizePosition(double p)
    => math.max(minPosition,math.min(maxPosition,p));

  void traverseEnd(){
    setState(() {
      initial = false;
      position = maxPosition;
      setColor(position);
    });
  }

  void traverseMiddle(){
    setState(() {
      initial = false;
      position = middlePosition;
      setColor(position);
    });
  }

  void traverseStart(){
    setState(() {
      initial = false;
      position = minPosition;
      setColor(position);
    });
  }
}

class dots extends StatelessWidget {
  double size;
  Color color;
  dots({@required this.size,this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color
      ),
    );
  }
}
