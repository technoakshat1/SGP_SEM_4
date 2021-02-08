import 'package:flutter/material.dart';

class TextOnlyFieldCircular extends StatefulWidget {
  TextOnlyFieldCircular(
      {Key key,
      this.labelText,
      @required this.labelFocusColor,
      @required this.labelUnfocusedColor,})
      : super(key: key);

  final String labelText;
  final Color labelFocusColor;
  final Color labelUnfocusedColor;

  @override
  _TextOnlyFieldCircularState createState() => _TextOnlyFieldCircularState();
}

class _TextOnlyFieldCircularState extends State<TextOnlyFieldCircular> {
  bool focus = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          if (hasFocus != null && hasFocus) {
            focus = true;
          } else {
            focus = false;
          }
        });
      },
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: focus ? widget.labelFocusColor : widget.labelUnfocusedColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: widget.labelFocusColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
      ),
    );
  }
}
