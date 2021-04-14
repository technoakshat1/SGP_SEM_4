import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AccentButtonCircular extends StatelessWidget {
  AccentButtonCircular({Key key, this.displayText, this.onPress})
      : super(key: key);

  final String displayText;
  Function onPress;

  @override
  Widget build(BuildContext context) {
    if (onPress == null) {
      onPress = () {};
    }

    return ElevatedButton(
      child: Text(
        displayText,
        style: Theme.of(context).primaryTextTheme.button,
      ),
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => Theme.of(context).accentColor),
        overlayColor:
            MaterialStateProperty.resolveWith<Color>((state) => Colors.black26),
        shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}
