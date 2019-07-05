import 'package:flutter/material.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'dart:math' as math;

class TransitionDots extends AnimatedWidget {

  TransitionDots({Key key, Listenable animation}): super(key: key, listenable: animation);
  Animation<int> get positionAnimation => IntTween(
    begin: 0,
    end: 50
  ).animate(
    CurvedAnimation(
      parent: super.listenable,
      curve: Interval(0.15, 0.3)
    )
  );
  Animation<double> get sizeAnimation => LoopedSizeAnimation().animate(
    CurvedAnimation(
      parent: super.listenable,
      curve: Interval(0.3, 0.8),
    )
  );

  @override
  Widget build(BuildContext context) {
    double animationSize = ScreenAwareSize(sizeAnimation.value, context);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double height = math.min(animationSize, deviceHeight);
    double width = math.min(animationSize, deviceWidth);
    Decoration decoration = BoxDecoration(
      color: Theme.of(context).primaryColor,
      shape: width < 0.9 * deviceWidth ? BoxShape.circle : BoxShape.rectangle
    );
    Widget dot = Container(
      width: width,
      height: height,
      decoration: decoration,
    );
    return IgnorePointer(
      child: Opacity(
        opacity: positionAnimation.value>0 ? 1.0 : 0.0 ,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Spacer(
                  flex: 101 - positionAnimation.value,
                ),
                dot,
                Spacer(
                  flex: 1 + positionAnimation.value,
                )
              ],
            ),
          ),
        ),
      ),      
    );
  }
}

class LoopedSizeAnimation extends Animatable<double>{
  final double defaultSize = 52.0;
  final double expansionRange = 30.0;
  final int numberOfCycles = 2;
  final double fullExpansionEdge = 0.8;

  double transform(double t){
    if (t < fullExpansionEdge) {
      double normalizedT = t / fullExpansionEdge;
      return defaultSize +
          math.sin(numberOfCycles * 2 * math.pi * normalizedT) * expansionRange;
    } else {
      double normalizedT = (t - fullExpansionEdge) / (1 - fullExpansionEdge);
      return defaultSize + normalizedT * 2000.0;
    }    
  }
}