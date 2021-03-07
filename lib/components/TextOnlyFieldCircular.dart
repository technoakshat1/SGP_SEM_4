import 'package:flutter/material.dart';

class TextOnlyFieldCircular extends StatefulWidget {
  TextOnlyFieldCircular(
      {Key key,
      this.labelText,
      @required this.labelFocusColor,
      @required this.labelUnfocusedColor,
      @required this.textController,
       this.onChange
      })
      : super(key: key);

  final String labelText;
  final Color labelFocusColor;
  final Color labelUnfocusedColor;
  final TextEditingController textController;
  final Function onChange;

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
        onChanged:widget.onChange,
        keyboardType: TextInputType.text,
        controller: widget.textController,
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
          enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: widget.labelUnfocusedColor,
            ),
          ),
        ),
      ),
    );
  }
}
