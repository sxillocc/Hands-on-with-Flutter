import 'package:flutter/material.dart';
import 'dart:math' as math;

class FancyRangeSlider extends StatefulWidget {
  @override
  _FancyRangeSliderState createState() => _FancyRangeSliderState();
}

class _FancyRangeSliderState extends State<FancyRangeSlider> {
  final double sliderHeight = 5;
  double sliderWidth;
  double curtainWidth=7.5;
  double fromLeft = 8.5;
  double fromLeft2 = 100;
  int value = 0;
  int value2 = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        sliderWidth = constraints.maxWidth - 32.0;
        value = positionToValue(fromLeft);
        value2 = positionToValue(fromLeft2);
        return Stack(
          alignment: Alignment(-1,0.716981132),
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 58,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                height: sliderHeight,
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(sliderHeight/2)
                ),
              ),
            ),
            _drawCurtains(),
            _drawLeftCircle(),
            _drawRightCircle()
          ],
        );
      },
    );
  }

  Widget _drawCurtains(){
    return Positioned(
      left: fromLeft + 15,
      top: 40+(15-sliderHeight)/2,
      child: Container(
        height: sliderHeight,
        width: (fromLeft2-fromLeft),
        color: Colors.blue,
      ),
    );
  }

  double _normalizeLeft(double num){
    num = math.max(8.5, math.min(num, fromLeft2-30));
    return num;
  }

  double _normalizeRight(double num){
    num = math.max(fromLeft+30, math.min(num, sliderWidth-6.5));
    return num;
  }

  int positionToValue(double p){
    return (10*(p - 8.5) / (sliderWidth-15)).round();
  }

  Widget _drawLeftCircle(){
    return Positioned(
      left: fromLeft,
      top: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 30,
            alignment: Alignment.center,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle
            ),
            child: Text('$value',style: TextStyle(fontSize: 20.0,color: Colors.white),),
          ),
          GestureDetector(
            onHorizontalDragUpdate: (DragUpdateDetails details){
                    Offset x = details.delta;
                    double dx = x.dx;
                    setState((){
                      fromLeft = _normalizeLeft(fromLeft + dx);
                      value = positionToValue(fromLeft);
                    });
                  },
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 255, 0.5),
                    shape: BoxShape.circle
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawRightCircle(){
    return Positioned(
      left: fromLeft2,
      top: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 30,
            alignment: Alignment.center,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle
            ),
            child: Text('$value2',style: TextStyle(fontSize: 20.0,color: Colors.white),),
          ),
          GestureDetector(
            onHorizontalDragUpdate: (DragUpdateDetails details){
              Offset x = details.delta;
              double dx = x.dx;
              setState((){
                fromLeft2 = _normalizeRight(fromLeft2 + dx);
                value2 = positionToValue(fromLeft2);
              });
            },
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 255, 0.5),
                  shape: BoxShape.circle
              ),
            ),
          ),
        ],
      ),
    );
  }

//  void _hzDragStart(DragStartDetails details){
//    RenderBox renderBox = context.findRenderObject();
//    Offset localOffset = renderBox.globalToLocal(details.globalPosition);
//    double newFromLeft = localOffset.dx;
//    double delta = newFromLeft - fromLeft - 16;
//    setState((){
//      fromLeft = fromLeft+delta;
//      fromLeft = _normalize(fromLeft);
//      value = (10*(fromLeft - 8.5) / (sliderWidth-15)).round();
//      curtainWidth = fromLeft-1;
//      print(value);
//    });
//  }
}
