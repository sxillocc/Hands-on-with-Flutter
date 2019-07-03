import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';

// export 'package:bmi_calculator/styles.dart';

double marginBottomAdapted(BuildContext context) => ScreenAwareSize(marginBottom, context);

double marginTopAdapted(BuildContext context) => ScreenAwareSize(marginTop, context);

double circleSizeAdapted(BuildContext context) =>
    ScreenAwareSize(circleSize, context);


const TextStyle labelsTextStyle = const TextStyle(
  color: labelsGrey,
  fontSize: labelsFontSize,
);

const double circleSize = 32.0;
const double marginBottom = 16.0;
const double marginTop = 26.0;
const double labelsFontSize = 13.0;
const Color labelsGrey = const Color.fromRGBO(216, 217, 223, 1.0);