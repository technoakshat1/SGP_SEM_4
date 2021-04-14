import 'package:flutter/material.dart';

class LogoAppBar extends StatefulWidget implements PreferredSizeWidget {
  LogoAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _LogoAppBarState createState() => _LogoAppBarState();
}

class _LogoAppBarState extends State<LogoAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
          width:500,
          child: Image.asset('assets/images/logo_text_dark_theme.png',
              fit: BoxFit.fill)),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        new IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {}),
        new IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {})
      ],
    );
  }
}
