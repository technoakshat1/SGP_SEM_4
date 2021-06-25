import "package:flutter/material.dart";

class CategoriesList extends StatefulWidget {
  CategoriesList({Key key}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
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
            title: Text("Breakfast"),
            onChanged: (_) {},
            value: true,
            activeColor: Theme.of(context).accentColor,
            checkColor: Colors.black,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: CheckboxListTile(
            title: Text("Lunch"),
            onChanged: (_) {},
            value: true,
            activeColor: Theme.of(context).accentColor,
            checkColor: Colors.black,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: CheckboxListTile(
            title: Text("High Tea"),
            onChanged: (_) {},
            value: true,
            activeColor: Theme.of(context).accentColor,
            checkColor: Colors.black,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: CheckboxListTile(
            title: Text("Brunch"),
            onChanged: (_) {},
            value: true,
            activeColor: Theme.of(context).accentColor,
            checkColor: Colors.black,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: CheckboxListTile(
            title: Text("Dinner"),
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
