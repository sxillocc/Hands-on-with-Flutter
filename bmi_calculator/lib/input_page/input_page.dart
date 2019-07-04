import 'package:flutter/material.dart';
import 'package:bmi_calculator/widget_utils.dart' as sizeObject;
import 'package:bmi_calculator/gender_card.dart';
import 'package:bmi_calculator/weight_card.dart';
import 'package:bmi_calculator/height_card.dart';
import 'package:bmi_calculator/pacman_slider.dart';

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      child: PacmanSlider(),
      alignment: Alignment.center,
      height: sizeObject.ScreenAwareSize(108.0, context),
      width: double.infinity,
    );
  }

  // Widget _tempCard(String label){
  //   return Card(
  //     child: Container(
  //       width: double.infinity,
  //       height: double.infinity,
  //       child: Text(label),
  //     ),
  //   );
  // }

}
