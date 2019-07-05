import 'dart:math' as math;

double calculateBMI({int height, int weight}) => 
    weight / _heightSquare(height);

double _heightSquare(int height) => math.pow(height/100, 2);

double minWeightAtHeight({height}) => 18.5 * _heightSquare(height);

double maxWeightAtHeight({height}) => 25 * _heightSquare(height);