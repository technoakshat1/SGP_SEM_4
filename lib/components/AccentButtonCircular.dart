import 'package:flutter/material.dart';

class AccentButtonCircular extends StatelessWidget {
  AccentButtonCircular({Key key,this.displayText,this.onPress}) : super(key: key);
  
  final String displayText;
  Function onPress;

  @override
  Widget build(BuildContext context) {
    
    if(onPress==null){
      onPress=(){};
    }

    return RaisedButton(
      child: Text(
        displayText,
        style: Theme.of(context).primaryTextTheme.button,
      ),
      onPressed: onPress,
      color: Theme.of(context).accentColor,
      splashColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
    );
  }
}
