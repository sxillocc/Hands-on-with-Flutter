import 'package:flutter/material.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class PacmanSlider extends StatefulWidget {
  @override
  _PacmanSliderState createState() => _PacmanSliderState();
}

class _PacmanSliderState extends State<PacmanSlider> 
      with TickerProviderStateMixin{
  int numberOfDots = 11;
  double minOpacity = 0.1;
  double maxOpacity = 0.5;
  AnimationController hintAnimationController;
  
  void initState(){
    super.initState();
    _initHintAnimationController();
    hintAnimationController.forward();
  }

  void dispose(){
    hintAnimationController.dispose();
    super.dispose();
  }

  _initHintAnimationController(){
    hintAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000)
    );
    hintAnimationController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        Future.delayed(Duration(milliseconds: 800),(){
          hintAnimationController.forward(from: 0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenAwareSize(24.0, context)),
      padding: EdgeInsets.symmetric(horizontal: ScreenAwareSize(24.0, context)),
      height: ScreenAwareSize(52.0, context),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          PacmanIcon(),
          Expanded(child: _drawDots(),)
        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8.0)
      ),
    );
  }

  Widget _drawDots(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(numberOfDots, _generateDots)
              ..add(Opacity(opacity: maxOpacity,child: Dot(size: 14.0))),
    );
  }

  Widget _generateDots(int index){
     Animation<double> animation = _initDotsAnimation(index);
     return AnimatedBuilder(
       animation: animation,
       builder: (BuildContext context,Widget child){
         return Opacity(
           opacity: animation.value,
           child: child,
         );
       },
       child: Dot(size: 9.0),
     ); 
  }

  Animation<double> _initDotsAnimation(int dotNumber){
    double lastDotStartTime = 0.4;
    double dotAnimationDuration = 0.6;
    double begin = lastDotStartTime * dotNumber / numberOfDots;
    double end = begin + dotAnimationDuration;

    return SinusoidalAnimation(min: minOpacity,max: maxOpacity).animate(
      CurvedAnimation(
        parent: hintAnimationController,
        curve: Interval(begin,end)
      )
    );
  }
}

class SinusoidalAnimation extends Animatable<double> {
  SinusoidalAnimation({this.min, this.max});

  final double min;
  final double max;

  @override
  double transform(double t) {
    return min + (max - min) * math.sin(math.pi * t);
  }
}

class Dot extends StatelessWidget {
  final double size;

  Dot({this.size, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle
      ),
    );
  }
}

class PacmanIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: ScreenAwareSize(16.0, context)),
      child: SvgPicture.asset(
        "images/pacman.svg",
        width: ScreenAwareSize(21.0, context),
        height: ScreenAwareSize(25.0, context),
      ),
    );
  }
}

