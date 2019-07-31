import 'package:flutter/material.dart';

class PlaceValueTextView extends StatelessWidget {

  final String text;
  final TextStyle style;

  PlaceValueTextView(this.text, {this.style});

  @override
  Widget build(BuildContext context) {
    var styleDisplay = style != null ? style : TextStyle();
    var textDisplay = text;
    var textLength = textDisplay.length;

    if(textLength > 3){
      var firstSpacePos = textLength % 3;
      var spacePos = firstSpacePos;
      var numberOfSpaces = textLength ~/ 3;

      for(int i = 0; i < numberOfSpaces; i++){
        if(i == 0 && firstSpacePos > 0){
          textDisplay = "${textDisplay.substring(0, firstSpacePos)} ${textDisplay.substring(firstSpacePos, textLength)}";
          ++textLength;

          ++spacePos;
        } else {
          spacePos += 3;
          textDisplay = "${textDisplay.substring(0, spacePos)} ${textDisplay.substring(spacePos, textLength)}";
          ++textLength;
          ++spacePos;
        }
      }
    }

    return Text(
      textDisplay,
      style: styleDisplay,
    );
  }
}