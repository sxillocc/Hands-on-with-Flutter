import 'package:flutter/material.dart';
import 'package:bmi_calculator/model/gender.dart';
import 'package:bmi_calculator/card_title.dart';
import 'package:bmi_calculator/widget_utils.dart' as sizeObject;
import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

double _circleSize(BuildContext context) => sizeObject.ScreenAwareSize(80.0, context);
const double _defaultGenderAngle = math.pi / 4 ;
const Map<Gender, double> _genderAngles = {
  Gender.female: -_defaultGenderAngle,
  Gender.other: 0.0,
  Gender.male: _defaultGenderAngle
};

class GenderCard extends StatefulWidget {
  final Gender initialGender;
  final ValueChanged<Gender> onGenderChanged;

  const GenderCard({Key key, this.initialGender,this.onGenderChanged}) : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> with SingleTickerProviderStateMixin {
  Gender selectedGender;
  AnimationController _arrowAnimationController;

  void initState(){
    selectedGender = widget.initialGender ?? Gender.other ;
    _arrowAnimationController = AnimationController(
      vsync: this,
      value: _genderAngles[selectedGender],
      upperBound: _defaultGenderAngle,
      lowerBound: -_defaultGenderAngle
    );
    super.initState();
  }

  void dispose(){
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: sizeObject.ScreenAwareSize(8.0, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CardTitle("GENDER"),
              Padding(
                padding: EdgeInsets.only(top: sizeObject.ScreenAwareSize(16.0, context)),
                child: _drawMainStack(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawMainStack(){
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _drawCircleIndicator(),
          GenderIconTranslated(gender: Gender.female),
          GenderIconTranslated(gender: Gender.other),
          GenderIconTranslated(gender: Gender.male),
          _drawGestureDetector(),
        ],
      ),
    );
  }

  Widget _drawCircleIndicator(){
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GenderCircle(),
        GenderArrow(listenable: _arrowAnimationController),
      ],
    );
  }

  Widget _drawGestureDetector(){
    return Positioned.fill(
      child: TapHandler(
        onGenderTapped: _setSelectedGender,
      ),
    );
  }

  void _setSelectedGender(gender) {
    setState((){
      selectedGender = gender;
      widget.onGenderChanged(gender);
    });
    _arrowAnimationController.animateTo(
      _genderAngles[gender],
      duration: Duration(milliseconds: 150)
    );
  }
}

class GenderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _circleSize(context),
      height: _circleSize(context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(244, 244, 244, 1.0)
      ),
    );
  }
}

class GenderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: sizeObject.ScreenAwareSize(6.0, context),
        top: sizeObject.ScreenAwareSize(8.0, context)
      ),
      child: Container(
        height: sizeObject.ScreenAwareSize(8.0, context),
        width: 1.0,
        color: Color.fromRGBO(216, 217, 223, 0.54),
      ),
    );
  }
}

class GenderIconTranslated extends StatelessWidget {

  static final Map<Gender,String> _genderImages = {
    Gender.female : "images/gender_female.svg",
    Gender.other : "images/gender_other.svg",
    Gender.male : "images/gender_male.svg",
  };

  final Gender gender;

  const GenderIconTranslated({Key key, this.gender}) : super(key: key);

  bool get _isOtherGender => gender == Gender.other;

  String get _assetName => _genderImages[gender];

  double _iconSize(BuildContext context){
    return sizeObject.ScreenAwareSize(_isOtherGender ? 22.0 : 16.0, context);
  }

  @override
  Widget build(BuildContext context) {
    Widget icon = Padding(
      padding: EdgeInsets.all(0.0),
      child: SvgPicture.asset(
        _assetName,
        height: _iconSize(context),
        width: _iconSize(context)
      ),
    );

    Widget rotatedIcon = Transform.rotate(
      angle: -_genderAngles[gender],
      child: icon,
    );

    Widget iconWithALine = Padding(
      padding: EdgeInsets.only(bottom: _circleSize(context)/2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          rotatedIcon,
          GenderLine(),
        ],
      ),
    );

    Widget rotatedIconWithALine = Transform.rotate(
      alignment: Alignment.bottomCenter,
      angle: _genderAngles[gender],
      child: iconWithALine,
    );

    Widget centerIconWithALine = Padding(
      padding: EdgeInsets.only(bottom: _circleSize(context) / 2),
      child: rotatedIconWithALine,
    );

    return centerIconWithALine;
  }
}

class GenderArrow extends AnimatedWidget {
  

  const GenderArrow({Key key, Listenable listenable}) : super(key: key, listenable: listenable);

  double _arrowLength(BuildContext context) => sizeObject.ScreenAwareSize(32.0, context);

  double _translationOffset(BuildContext context) => _arrowLength(context) * -0.4 ;
  
  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Transform.rotate(
      angle: animation.value,
      child: Transform.translate(
        offset: Offset(0.0,_translationOffset(context)),
        child: Transform.rotate(
          angle: -_defaultGenderAngle,
          child: SvgPicture.asset(
            'images/gender_arrow.svg',
            height: _arrowLength(context),
            width: _arrowLength(context)
          ),
        ),
      ),
    );
  }
}

class TapHandler extends StatelessWidget {
  final Function(Gender) onGenderTapped;

  const TapHandler({Key key, this.onGenderTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(child: GestureDetector(onTap: () => onGenderTapped(Gender.female))),
        Expanded(child: GestureDetector(onTap: () => onGenderTapped(Gender.other))),
        Expanded(child: GestureDetector(onTap: () => onGenderTapped(Gender.male))),
      ],
    );
  }
}