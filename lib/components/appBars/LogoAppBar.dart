import 'package:flutter/material.dart';

class LogoAppBar extends StatefulWidget implements PreferredSizeWidget {
  LogoAppBar({Key key, this.user, this.scaffoldState})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0
  final user;
  final scaffoldState;

  @override
  _LogoAppBarState createState() => _LogoAppBarState();
}

class _LogoAppBarState extends State<LogoAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Container(
        child: TextButton(
          onPressed: () {
            widget.scaffoldState.currentState.openDrawer();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            child: widget.user == null||widget.user.photoUrl==null
                ? Image.asset('assets/images/logo_dark_theme.png')
                : Image.network(
                    widget.user.photoUrl,
                    fit: BoxFit.fill,
                    height: 35,
                    width: 35,
                  ),
          ),
        ),
      ),
      title: Container(
          width: 500,
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
      ],
    );
  }
}
