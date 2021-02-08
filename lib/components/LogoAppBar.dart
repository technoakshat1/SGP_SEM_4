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
      title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
    );
  }
}
