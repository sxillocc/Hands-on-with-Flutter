import 'package:flutter/material.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:bmi_calculator/card_title.dart';
import 'package:bmi_calculator/height_style.dart';
import 'package:bmi_calculator/height_picker.dart';

class HeightCard extends StatefulWidget {
  final int height;
  
  HeightCard({this.height, Key key}) : super(key: key);

  @override
  _HeightCardState createState() => _HeightCardState();
}

class _HeightCardState extends State<HeightCard> {
  int height;

  void initState(){
    super.initState();
    height = widget.height ?? 170 ;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: ScreenAwareSize(8.0, context)),
        child: Column(
          children: <Widget>[
            CardTitle("HEIGHT",subtitle:"(CM)"),
            Expanded(
                child: Padding(
                padding: EdgeInsets.only(bottom: ScreenAwareSize(12.0, context)),
                child: LayoutBuilder(
                  builder: (context,constraints){
                    return HeightPicker(
                      widgetHeight: constraints.maxHeight,
                      height: height,
                      onChanged: (val) => setState(() => height = val),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

  // final int maxHeight;
  // final int minHeight;
  // final int widgetHeight;
  // final int height;
  // final ValueChanged<int> onChanged;

  // HeightCard({
  //   Key key,
  //   this.height,
  //   this.widgetHeight,
  //   this.minHeight = 145,
  //   this.maxHeight = 190,
  //   this.onChanged
  // }) : super(key: key);