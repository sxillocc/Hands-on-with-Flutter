import 'package:bmi_calculator/fade_route.dart';
import 'package:bmi_calculator/transition_dots.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/widget_utils.dart' as sizeObject;
import 'package:bmi_calculator/gender_card.dart';
import 'package:bmi_calculator/weight_card.dart';
import 'package:bmi_calculator/height_card.dart';
import 'package:bmi_calculator/pacman_slider.dart';
import 'package:bmi_calculator/result_page.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> 
      with TickerProviderStateMixin{

  AnimationController _submitAnimationController;

  void initState(){
    super.initState();
    _submitAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _submitAnimationController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        _goToResultPage().then((_)=>_submitAnimationController.reset());
      }
    });
  }

  _goToResultPage() async {
    return Navigator.of(context).push(FadeRoute(
      builder: (context) => ResultPage(),
    ));
  }
  
  void dispose(){
    _submitAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[ 
        Scaffold(
          body: Padding(
            padding: MediaQuery.of(context).padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitle(context),
                Expanded(child: _buildCards(context),),
                _buildBottom(context),
              ],
            ),
          ),
        ),
        TransitionDots(
          animation: _submitAnimationController,
        )
      ]
    );
  }

  Widget _buildTitle(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
        left: 24.0,
        top: sizeObject.ScreenAwareSize(56.0,context)
      ),
      child: Text(
        "BMI Calculator",
        style: new TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCards(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
        left: 14.0,
        right: 14.0,
        top: sizeObject.ScreenAwareSize(32.0, context)
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: GenderCard(),),
                Expanded(child: WeightCard(),)
              ],
            ),
          ),
          Expanded(child: HeightCard(),)
        ],
      ),
    );
  }

  Widget _buildBottom(BuildContext context){
    return Container(
      child: PacmanSlider(
        submitAnimationController: _submitAnimationController,
        onSubmit: ()=>_onPacmanSubmit(),
      ),
      alignment: Alignment.center,
      height: sizeObject.ScreenAwareSize(108.0, context),
      width: double.infinity,
    );
  }

  void _onPacmanSubmit(){
    _submitAnimationController.forward();
  }
}
