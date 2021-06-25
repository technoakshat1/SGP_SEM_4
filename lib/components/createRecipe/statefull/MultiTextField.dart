import 'dart:collection';

import "package:flutter/material.dart";

import '../../authentication/statefulWidgets/TextOnlyFieldCircular.dart';

class MultiTextField extends StatefulWidget {
  MultiTextField({Key key}) : super(key: key);

  @override
  _MultiTextFieldState createState() => _MultiTextFieldState();
}

class _MultiTextFieldState extends State<MultiTextField> {
 List<Widget> tree = List.empty(growable: true);
 int count=-1;
 
 
  void addIngredientInputBox() {
    DateTime time = DateTime.now();
    TextEditingController controller = TextEditingController();
    count++;
    Widget toRender = Dismissible(
      onDismissed: (_) {
        setState(() {
          tree.remove(count);
          count--;
        });
      },
      key: ValueKey(time),
      background: Container(
        margin: EdgeInsets.all(10),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
      ),
      child: Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 330,
              child: TextOnlyFieldCircular(
                labelText: "",
                labelFocusColor: Color(0xffaf0069),
                labelUnfocusedColor: Theme.of(context).accentColor,
                onChange: (_) {
                  print(_);
                },
                textController: controller,
              ),
            ),
          ],
        ),
      ),
    );
    setState(() {
      tree.add(toRender);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...tree,
        Container(
          margin: EdgeInsets.all(10),
          child: ElevatedButton.icon(
            onPressed: addIngredientInputBox,
            icon: Icon(Icons.add),
            label: Text("Add"),
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
