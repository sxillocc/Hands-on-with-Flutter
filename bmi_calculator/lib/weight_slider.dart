import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class WeightSlider extends StatelessWidget {

  WeightSlider({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.width,
    @required this.value,
    @required this.onChanged
  })  : scrollController = new ScrollController(
          initialScrollOffset: (value - minValue) * width / 3,
        ),
        super(key: key);

  final int minValue,maxValue,value;
  final double width;
  final ValueChanged<int> onChanged;
  final ScrollController scrollController;

  double get itemExtent => width / 3; 

  int _indexToValue(int index) => minValue + (index - 1);

  @override
  Widget build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3;
    return NotificationListener(
      onNotification: _onNotification,
      child: new ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context,int index){
          final int itemValue = _indexToValue(index);
          bool isExtra = index == 0 || index == itemCount - 1;

          return isExtra
                ? new Container()
                : GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: ()=>_animateTo(itemValue,durationMillis: 50), 
                    child:  FittedBox(
                      child: Text(
                        itemValue.toString(),
                        style: _getTextStyle(itemValue),
                      ),
                      fit: BoxFit.scaleDown,
                    )
                  );
        },
      ),
    );
  }

  TextStyle _getTextStyle(int itemValue){
    return itemValue == value
    ? TextStyle(
      color: Color.fromRGBO(77, 123, 243, 1.0),
      fontSize: 28.0
    ) 
    : TextStyle(
      color: Color.fromRGBO(196, 197, 203, 1.0),
      fontSize: 13.0
    );
  }

  int _offsetToMiddleIndex(double offset) => (offset + width/2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset){
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    middleValue = math.max(minValue, math.min(maxValue, middleValue));
    return middleValue;
  }

  bool _userStoppedScrolling(Notification notification){
    return  notification is UserScrollNotification &&
            notification.direction == ScrollDirection.idle &&
            scrollController.position.activity is! HoldScrollActivity;
  }

  void _animateTo(int valueToSelect, {int durationMillis = 200}){
    // if(durationMillis == 50)
    //   print('onTap function called with itemValue = $valueToSelect \n');
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    scrollController.animateTo(
      targetExtent,
      duration: new Duration(milliseconds: durationMillis),
      curve: Curves.decelerate
    );
  }

  bool _onNotification(Notification notification){
    if(notification is ScrollNotification){
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);

      if(_userStoppedScrolling(notification)){
        _animateTo(middleValue);
        // print("middle-value = $middleValue ,Value(index = 1 + offset/itemExtent) = ${_indexToValue((notification.metrics.pixels ~/ itemExtent) + 1)}\n");
      }

      if(middleValue != value){
        onChanged(middleValue);
      }
    }
    return true;
  }
}