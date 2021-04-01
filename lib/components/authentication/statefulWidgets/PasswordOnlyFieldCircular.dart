import 'package:flutter/material.dart';

class PasswordOnlyFieldCircular extends StatefulWidget {
  PasswordOnlyFieldCircular(
      {Key key,
      this.labelText,
      @required this.labelFocusColor,
      @required this.labelUnfocusedColor,
      @required this.textController,
      this.onChange})
      : super(key: key);

  final Color labelFocusColor;
  final Color labelUnfocusedColor;
  final String labelText;
  final TextEditingController textController;
  final Function onChange;

  @override
  _PasswordOnlyFieldCircularState createState() =>
      _PasswordOnlyFieldCircularState();
}

class _PasswordOnlyFieldCircularState extends State<PasswordOnlyFieldCircular> {
  bool focus = false;
  bool obscureText = true;
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
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
           TextFormField(
            onChanged: widget.onChange,
            obscureText: obscureText,
            keyboardType: TextInputType.visiblePassword,
            controller: widget.textController,
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(
                  color: focus
                      ? widget.labelFocusColor
                      : widget.labelUnfocusedColor),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                borderSide: BorderSide(
                  color: widget.labelFocusColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                borderSide: BorderSide(
                  color: widget.labelUnfocusedColor,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                obscureText=!obscureText;
              });
            },
          ),
        ],
      ),
    );
  }
}
