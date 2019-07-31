import 'package:flutter/material.dart';
import 'package:follower_detective/values/app_colors.dart';
import 'package:follower_detective/widgets/place_value_text_view.dart';

class InfoBox extends StatefulWidget {

  String value;
  String label;
  bool onlyLabel;

  InfoBox({this.value, @required this.label, this.onlyLabel});

  @override
  _InfoBoxState createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> {

  Color bgColor = AppColors.colorPrimary;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          color: bgColor,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Value(
                  show: widget.onlyLabel != null ? !widget.onlyLabel : true,
                  value: widget.value,
                ),
                Text(
                  widget.label != null ? widget.label : "",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18
                  ),
                )
              ],
            ),
          )
      ),
      onTapDown: (details) {
        setState(() {
          bgColor = AppColors.colorPrimary[400];
        });
      },
      onTapUp: (details) {
        setState(() {
          bgColor = AppColors.colorPrimary;
        });
      },
      onTapCancel: () {
        setState(() {
          bgColor = AppColors.colorPrimary;
        });
      },
    );
  }
}


class Value extends StatelessWidget {

  final bool show;
  final String value;

  const Value({Key key, this.show, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final valueDisplay = value != null ? value : "";

    return show
    ? PlaceValueTextView(
      valueDisplay,
      style: TextStyle(
          fontFamily: "Krub",
          fontSize: 25,
          color: Colors.deepOrange
      ),
    )
    : Container(width: 0, height: 0,);
  }
}