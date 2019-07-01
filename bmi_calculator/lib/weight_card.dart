import 'package:flutter/material.dart';
import 'package:bmi_calculator/card_title.dart';
import 'package:bmi_calculator/widget_utils.dart' show ScreenAwareSize;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bmi_calculator/weight_slider.dart';

class WeightCard extends StatefulWidget {
  final int initialWeight;

  const WeightCard({Key key,this.initialWeight}): super(key:key);
  
  @override
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  int weight;

  void initState(){
    super.initState();
    weight = widget.initialWeight ?? 70;
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: ScreenAwareSize(32.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle("WEIGHT",subtitle: "(KG)",),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _drawSlider(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawSlider(){
    return WeightBackground(
      child: LayoutBuilder(
        builder: (context, constraints){
        return constraints.isTight
          ? Container()
          : WeightSlider(
              minValue: 30,
              maxValue: 110,
              width: constraints.maxWidth,
              value: weight,
              onChanged: (val)=> setState(() => weight = val),
            );
        }
      ),
    );
  }
}

class WeightBackground extends StatelessWidget {
  final Widget child;

  WeightBackground({Key key,this.child}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: ScreenAwareSize(100.0, context),
          decoration: BoxDecoration(
              color: Color.fromRGBO(244, 244, 244, 1.0),
              borderRadius: BorderRadius.circular(ScreenAwareSize(50.0, context))
          ),
          child: child,
        ),
        SvgPicture.asset(
          "images/weight_arrow.svg",
          height: ScreenAwareSize(10.0, context),
          width: ScreenAwareSize(18.0, context),
        )
      ],
    );
  }
}