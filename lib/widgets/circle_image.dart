import 'dart:io';
import 'package:flutter/material.dart';
import 'package:follower_detective/values/app_gradients.dart';


// ignore: must_be_immutable
class CircleImage extends StatelessWidget {

  String imagePath;
  double borderWidth = 5;
  double diameter = 100;
  double imageDiameter = 0;

  CircleImage(this.imagePath, {this.diameter, this.borderWidth,});

  @override
  Widget build(BuildContext context) {
    imageDiameter = diameter - borderWidth;

    return FutureBuilder<File>(
      future: _getLocalFile(imagePath),
      builder: (context, ppSnapshot){return ppSnapshot.hasData
          ? Center(
        child: ClipOval(
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              gradient: AppGradients.circleImageBorder,
            ),
            child: Center(
              child: ClipOval(
                  child: Image.file(
                    ppSnapshot.data,
                    width: imageDiameter,
                    height: imageDiameter,
                  )
              ),
            ),
          ),
        ),
      )
          : CircularProgressIndicator();
      },
    );
  }


  Future<File> _getLocalFile(String filename) async {
    File f = new File(filename);
    return f;
  }
}