import 'package:flutter/material.dart';

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({WidgetBuilder builder,RouteSettings settings})
    : super(builder: builder, settings: settings);

  Duration get transitionDuration => const Duration(milliseconds: 500); 

  Widget buildTransitions(BuildContext context,Animation<double> animation, 
    Animation<double> secondaryAnimation,Widget child){

    return FadeTransition(opacity: animation,child: child,);    
  }

}