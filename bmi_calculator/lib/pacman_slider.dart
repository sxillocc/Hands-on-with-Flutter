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
  int numberOfDots = 9;
  double _pacmanPostion = 24.0;
  double minOpacity = 0.1;
  double maxOpacity = 0.5;
  double _pacmanMinPosition() => 24.0;
  double _pacmanMaxPosition({double width}) => width - 2 * ScreenAwareSize(24.0, context) + ScreenAwareSize(23.0, context)/2;
  
  AnimationController hintAnimationController;
  AnimationController pacmanAnimationController;
  Animation<double> pacmanAnimation;
  
  void initState(){
    super.initState();
    _initHintAnimationController();
    _initPacmanAnimationController();
    hintAnimationController.forward();
  }

  void dispose(){
    hintAnimationController.dispose();
    pacmanAnimationController.dispose();
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

  _initPacmanAnimationController(){
    pacmanAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  _initPacmanAnimation({width}){
    Animation<double> animation = Tween(
      begin: _pacmanMinPosition(),
      end: _pacmanMaxPosition(width: width)
    ).animate(pacmanAnimationController);

    animation.addListener((){
      setState(() {
        _pacmanPostion = animation.value;
      });
      if(animation.status == AnimationStatus.completed){
        Future.delayed(Duration(seconds: 1),()=>_resetPacman());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Decoration decoration = BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8.0)
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenAwareSize(24.0, context)),
      height: ScreenAwareSize(52.0, context),
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context,constraints){
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _animateToEnd(width: constraints.maxWidth),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                _drawDots(),
                _drawDotCurtain(_pacmanPostion, constraints.maxWidth, constraints.maxHeight),
                _drawPacman(sliderWidth: constraints.maxWidth),
              ],
            ),
          );
        },
      ),
      decoration: decoration,
    );
  }

  Widget _drawDotCurtain(double position, double width,double height){
    width = position;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8.0)
      ),
    );
  }

  Widget _drawPacman({double sliderWidth}){
    if(pacmanAnimation == null && sliderWidth != 0){
      _initPacmanAnimation(width: sliderWidth);
    }
    return Positioned(
      left: _pacmanPostion,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) => _onPacmanDragUpdate(sliderWidth,details),
        onHorizontalDragEnd: (details) => _onPacmanDragEnd(sliderWidth, details),
        child: PacmanIcon()
      ),
    );
  }

  _onPacmanDragUpdate(double width,DragUpdateDetails details){
    setState(() {
      _pacmanPostion += details.delta.dx ;
      _pacmanPostion = _normalizePacmanPostion(width ,_pacmanPostion);
    });
  }

  _normalizePacmanPostion(double width,double position){
      width = _pacmanMaxPosition(width: width);
      position = math.max(_pacmanMinPosition(), math.min(position, width));
      return position;
  }

  _onPacmanDragEnd(double width,DragEndDetails details){
    bool isLessThenHalf = _pacmanPostion + ScreenAwareSize(23.0, context)/2 < 0.5 * width;
    if(isLessThenHalf){
      _resetPacman();
    }else{
      _animateToEnd(width: width);
    }

  }

  void _animateToEnd({double width}){
    pacmanAnimationController.forward(
      from: _pacmanPostion/_pacmanMaxPosition(width: width)
    );
  }

  void _resetPacman() {
    setState(() {
      _pacmanPostion = _pacmanMinPosition();
    });
  }

  Widget _drawDots(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenAwareSize(24.0, context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(numberOfDots, _generateDots)
                ..add(Opacity(opacity: maxOpacity,child: Dot(size: 14.0))),
      ),
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
      padding: EdgeInsets.only(right: ScreenAwareSize(0.0, context)),
      child: SvgPicture.asset(
        "images/pacman.svg",
        width: ScreenAwareSize(21.0, context),
        height: ScreenAwareSize(25.0, context),
      ),
    );
  }
}

