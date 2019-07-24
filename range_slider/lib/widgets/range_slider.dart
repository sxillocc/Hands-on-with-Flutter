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
  double fromLeft = 0;
  double fromLeft2 = 0;
  int value = 0;
  int value2 = 0;
  double sliderPadding = 16;
  double pinDiameter = 15;
  double cardDiameter = 30;
  double get borderSize => (cardDiameter - pinDiameter)/2;
  double get minPos => sliderPadding - (cardDiameter-pinDiameter)/2;
  double get maxPos => sliderWidth + sliderPadding
                      -pinDiameter - (cardDiameter-pinDiameter)/2;
  bool _leftActive = false;
  bool _rightActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fromLeft = minPos;
    fromLeft2 = fromLeft + 3*cardDiameter ;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        sliderWidth = constraints.maxWidth - 2*sliderPadding;
        value = positionToValue(fromLeft);
        value2 = positionToValue(fromLeft2);
        return Stack(
          children: <Widget>[
            _sliderContainer(),
            _sliderBar(),
            _drawCurtains(),
            _drawLeftCircle(),
            _drawRightCircle()
          ],
        );
      },
    );
  }

  Widget _sliderContainer(){
    return Container(
      width: double.infinity,
      height: cardDiameter+pinDiameter + borderSize,
    );
  }

  Widget _sliderBar(){
    return Positioned(
      top: cardDiameter+(pinDiameter/2)-(sliderHeight/2),
      left: sliderPadding,
        child: Container(
          width: sliderWidth,
          height: sliderHeight,
          decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(sliderHeight/2)
          ),
        ),

    );
  }

  Widget _drawCurtains(){
    return Positioned(
      left: fromLeft + cardDiameter/2,
      top: cardDiameter+(pinDiameter/2)-(sliderHeight/2),
      child: Container(
        height: sliderHeight,
        width: (fromLeft2-fromLeft),
        color: Colors.blue,
      ),
    );
  }

  double _normalizeLeft(double num){
    num = math.max(minPos, math.min(num, fromLeft2-cardDiameter));
    return num;
  }

  double _normalizeRight(double num){
    num = math.max(fromLeft+cardDiameter, math.min(num, maxPos));
    return num;
  }

  int positionToValue(double p){
    return (10*(p - minPos) / (sliderWidth-pinDiameter)).round();
  }

  Widget _drawLeftCircle(){
    return Positioned(
      top: 0,
      left: fromLeft,
      child: Stack(
        children:[
            Positioned(
              top: cardDiameter-borderSize,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _leftActive ? Color.fromRGBO(0, 0, 0, 0.5) : Color.fromRGBO(0, 0, 255, 0.0)
                ),
                width: pinDiameter + 2*borderSize,
                height: pinDiameter + 2*borderSize,
              ),
            ),
            Container(
              height: cardDiameter+pinDiameter + borderSize,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: cardDiameter,
                    alignment: Alignment.center,
                    width: cardDiameter,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle
                    ),
                    child: Text('$value',style: TextStyle(fontSize: cardDiameter-10,color: Colors.white),),
                  ),
                  GestureDetector(
                    child: Container(
                      width: pinDiameter,
                      height: pinDiameter,
                      decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle
                      ),
                    ),
                    onHorizontalDragUpdate: (DragUpdateDetails details){
                      Offset x = details.delta;
                      double dx = x.dx;
                      setState((){
                        _leftActive = true;
                        fromLeft = _normalizeLeft(fromLeft + dx);
                        value = positionToValue(fromLeft);
                      });
                    },
                    onHorizontalDragEnd: (DragEndDetails _){
                      setState(() {
                        _leftActive = false;
                      });
                    },
                  ),
                ],
              ),
            ),
        ]
      ),
    );
  }

  Widget _drawRightCircle(){
    return Positioned(
      top: 0,
      left: fromLeft2,
      child: Stack(
        children: [
          Positioned(
            top: cardDiameter-borderSize,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _rightActive ? Color.fromRGBO(0, 0, 0, 0.5) : Color.fromRGBO(0, 0, 255, 0.0)
              ),
              width: pinDiameter + 2*borderSize,
              height: pinDiameter + 2*borderSize,
            ),
          ),
          Container(
            height: cardDiameter+pinDiameter + borderSize,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: cardDiameter,
                  alignment: Alignment.center,
                  width: cardDiameter,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle
                  ),
                  child: Text('$value2',style: TextStyle(fontSize: cardDiameter-10,color: Colors.white),),
                ),
                GestureDetector(
                  child: Container(
                    width: pinDiameter,
                    height: pinDiameter,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle
                    ),
                  ),
                  onHorizontalDragUpdate: (DragUpdateDetails details){
                    Offset x = details.delta;
                    double dx = x.dx;
                    setState((){
                      _rightActive = true;
                      fromLeft2 = _normalizeRight(fromLeft2 + dx);
                      value2 = positionToValue(fromLeft2);
                    });
                  },
                  onHorizontalDragEnd: (DragEndDetails _){
                    setState(() {
                      _rightActive = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ]
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
