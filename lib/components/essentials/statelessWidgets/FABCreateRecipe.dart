import 'package:flutter/material.dart';

class FABCreateRecipe extends StatelessWidget{
  FABCreateRecipe({this.onPress});
  final Function onPress;
  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
       child: Icon(Icons.add),
        onPressed: onPress,
        backgroundColor:Theme.of(context).accentColor,
    );
  }
}