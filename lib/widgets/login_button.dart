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
import 'package:follower_detective/values/english.dart';

class LoginButton extends StatefulWidget{
  final double fontSize;
  final VoidCallback onPressed;

  LoginButton(this.fontSize, {this.onPressed});

  @override
  _LoginButtonState createState() => _LoginButtonState();
}


class _LoginButtonState extends State<LoginButton>{
  double _paddingLeft = 0;
  double _paddingTop = 0;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(2, 2, 0, 0),
          child: Text(
            English.login_all_caps,
            style: TextStyle(
              fontSize: widget.fontSize,
              color: Colors.pinkAccent,
            ),
          ),
        ),
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.fromLTRB(_paddingLeft, _paddingTop, 0, 0),
            child: Text(
              English.login_all_caps,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
          onTap: widget.onPressed,
          onTapDown: (details){
            setState(() {
              _paddingLeft = 2;
              _paddingTop = 2;
            });
          },
          onTapUp: (details){
            setState(() {
              _paddingLeft = 0;
              _paddingTop = 0;
            });
          },
          onTapCancel: (){
            setState(() {
              _paddingLeft = 0;
              _paddingTop = 0;
            });
          },
        )
      ],
    );
  }
}