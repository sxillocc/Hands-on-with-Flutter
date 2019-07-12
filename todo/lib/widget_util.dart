import 'package:flutter/material.dart';

double _baseHeight = 650;

double screenAwareSize(double size,BuildContext context) =>
    size * MediaQuery.of(context).size.height/ _baseHeight ;