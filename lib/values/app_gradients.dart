import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppGradients {
  static Gradient pinkBlueLinear = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.0, 1.0],
    colors: <Color>[
      Colors.pink,
      Colors.lightBlue],
  );


  static Gradient circleImageBorder = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.0, 1.0],
    colors: [
      Colors.indigo,
      Colors.pink,
    ],
  );
}