
import "package:flutter/material.dart";

class MultiSteps extends StatefulWidget {
  MultiSteps({Key key}) : super(key: key);

  @override
  _MultiStepsState createState() => _MultiStepsState();
}

class _MultiStepsState extends State<MultiSteps> {
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
              width: 320,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              child: TextField(
                maxLines: 7,
                maxLength: 255,
                decoration: InputDecoration(border: InputBorder.none),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Theme.of(context).accentColor,
                ),
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
          width:200,
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
