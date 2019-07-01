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

class CustomTextField extends StatelessWidget{
  String label;
  String imageAsset;

  CustomTextField(this.imageAsset, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Colors.white10
              ),
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(imageAsset, width: 30, height: 30,),
                Padding(padding: EdgeInsets.all(5),),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: label,
                      hintStyle: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}