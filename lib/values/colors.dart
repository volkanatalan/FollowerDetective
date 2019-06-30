/*
   Copyright 2019 Volkan ATALAN

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
 */

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