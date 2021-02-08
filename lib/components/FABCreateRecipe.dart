import 'package:flutter/material.dart';

class FABCreateRecipe extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
       child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor:Theme.of(context).accentColor,
    );
  }
}