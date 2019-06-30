import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor colorPrimary = MaterialColor(
    0xFF292929,
    <int, Color>{
      50: Color(0xFFa0a0a0),
      100: Color(0xFF888888),
      200: Color(0xFF707070),
      300: Color(0xFF595959),
      400: Color(0xFF414141),
      500: Color(0xFF292929),
      600: Color(0xFF121212),
      700: Color(0xFF101010),
      800: Color(0xFF0e0e0e),
      900: Color(0xFF0c0c0c),
    },
  );


  static const MaterialColor colorPrimaryDark = MaterialColor(
    0xFF121212,
    <int, Color>{
      50: Color(0xFF888888),
      100: Color(0xFF707070),
      200: Color(0xFF595959),
      300: Color(0xFF414141),
      400: Color(0xFF292929),
      500: Color(0xFF121212),
      600: Color(0xFF101010),
      700: Color(0xFF0e0e0e),
      800: Color(0xFF0c0c0c),
      900: Color(0xFF0a0a0a),
    },
  );


  static const MaterialColor background = colorPrimaryDark;
}