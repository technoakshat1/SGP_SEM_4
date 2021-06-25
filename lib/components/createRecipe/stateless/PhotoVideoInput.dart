import 'package:flutter/material.dart';

class PhotoVideoInput extends StatelessWidget {
  const PhotoVideoInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Theme.of(context).accentColor,
        ),
      ),
      child: TextButton(
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              child: Icon(
                Icons.add_a_photo,
                size: 50,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "Add photos and video\n(video should not exceed 10 mins)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
