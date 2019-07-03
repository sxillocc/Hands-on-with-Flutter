import 'package:flutter/material.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:bmi_calculator/height_style.dart';
import 'package:bmi_calculator/height_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class HeightPicker extends StatefulWidget {

  final int maxHeight;
  final int minHeight;
  final double widgetHeight;
  final int height;
  final ValueChanged<int> onChanged;

  HeightPicker({
    Key key,
    this.height,
    this.widgetHeight,
    this.minHeight = 145,
    this.maxHeight = 190,
    this.onChanged
  }) : super(key: key);

  int get totalUnits => maxHeight - minHeight;

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {

  double get _pixelsPerUnit{
    return _sliderRange / widget.totalUnits;
  }

  double get _sliderPostion{
    double halfOfBottomLabel = labelsFontSize / 2;
    int unitsFromBottom = widget.height - widget.minHeight;
    double marginBottom = marginBottomAdapted(context);
    return halfOfBottomLabel + marginBottom + unitsFromBottom * _pixelsPerUnit - (circleSizeAdapted(context)/2 + 1);
  }

  double get _sliderRange {
    double totalHeight = widget.widgetHeight;
    double marginTop = marginTopAdapted(context);
    double marginBottom = marginBottomAdapted(context);
    double fontSize = labelsFontSize;

    return totalHeight - (marginTop + marginBottom + fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: _onTapDown,
      onVerticalDragStart: _onDragStart,
      onVerticalDragUpdate: _onDragUpdate,
      child: Stack(
        children: <Widget>[
          _drawPersonImage(),
          _drawSlider(),
          _drawLabels(),
        ],
      ),
    );
  }

  _onTapDown(TapDownDetails tapDownDetails){
    int height = _globalOffsetToHeight(tapDownDetails.globalPosition);
    // print("height = $height \n");
    widget.onChanged(_normalizeHeight(height));
  }

  int _normalizeHeight(int height){
    return math.max(widget.minHeight, math.min(widget.maxHeight, height));
  }

  int _globalOffsetToHeight(Offset globalOffset){
    RenderBox getBox = context.findRenderObject();
    Offset localOffset = getBox.globalToLocal(globalOffset);
    double dy = localOffset.dy;
    dy = widget.widgetHeight - dy - marginBottomAdapted(context) - labelsFontSize/2;
    return widget.minHeight + dy ~/ _pixelsPerUnit ;
  }

  _onDragStart(DragStartDetails dragStartDetails){
    int height = _globalOffsetToHeight(dragStartDetails.globalPosition);
    height = _normalizeHeight(height);
    widget.onChanged(height);
  }

  _onDragUpdate(DragUpdateDetails dragUpdateDetails){
    int height = _globalOffsetToHeight(dragUpdateDetails.globalPosition);
    height = _normalizeHeight(height);
    widget.onChanged(height);
    // print("height = $height");
  }

  Widget _drawLabels(){
    int itemCount = widget.totalUnits ~/ 5 + 1;
    List<Widget> labels = List.generate(
      itemCount, (index){
        return Text(
          "${widget.maxHeight - 5*index}",
          style: labelsTextStyle,
        );  
      });
    return Align(
      alignment: Alignment.centerRight,
      child: IgnorePointer(
        child: Padding(
          padding: EdgeInsets.only(
            right: ScreenAwareSize(12.0, context),
            top: marginTopAdapted(context),
            bottom: marginBottomAdapted(context)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: labels
          ),
        ),
      ),
    );
  }

  Widget _drawSlider(){
    return Positioned(
      child: HeightSlider(height: widget.height,),
      left: 0.0,
      right: 0.0,
      bottom: _sliderPostion,
    );
  }

  Widget _drawPersonImage(){
    double personImageHeight = _sliderPostion + marginBottomAdapted(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: SvgPicture.asset(
        "images/person.svg",
        height: personImageHeight,
        width: personImageHeight/3,
      ),
    );
  }
}