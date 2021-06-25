import 'package:flutter/material.dart';

class FilterList extends StatefulWidget {
  FilterList({Key key}) : super(key: key);

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
             Container(
              padding: EdgeInsets.all(10),
              child: CheckboxListTile(
                title: Text("All"),
                onChanged: (_) {},
                value: true,
                activeColor: Theme.of(context).accentColor,
                checkColor: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: CheckboxListTile(
                title: Text("Veg"),
                onChanged: (_) {},
                value: true,
                activeColor: Theme.of(context).accentColor,
                checkColor: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: CheckboxListTile(
                title: Text("Non-veg"),
                onChanged: (_) {},
                value: true,
                activeColor: Theme.of(context).accentColor,
                checkColor: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: CheckboxListTile(
                title: Text("Jain"),
                onChanged: (_) {},
                value: true,
                activeColor: Theme.of(context).accentColor,
                checkColor: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: CheckboxListTile(
                title: Text("Diet"),
                onChanged: (_) {},
                value: true,
                activeColor: Theme.of(context).accentColor,
                checkColor: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: CheckboxListTile(
                title: Text("Probiotic"),
                onChanged: (_) {},
                value: true,
                activeColor: Theme.of(context).accentColor,
                checkColor: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: CheckboxListTile(
                title: Text("Low Salt"),
                onChanged: (_) {},
                value: true,
                activeColor: Theme.of(context).accentColor,
                checkColor: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: CheckboxListTile(
                title: Text("Festive"),
                onChanged: (_) {},
                value: true,
                activeColor: Theme.of(context).accentColor,
                checkColor: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: CheckboxListTile(
                title: Text("Fasting"),
                onChanged: (_) {},
                value: true,
                activeColor: Theme.of(context).accentColor,
                checkColor: Colors.black,
              ),
            ),
      ],
    );
  }
}