import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/backend/bloc/ThemeChanger.dart';

import "../components/essentials/statelessWidgets/AppDrawer.dart";
import "../components/appBars/LogoAppBar.dart";

import '../backend/httpController/AuthController.dart';
import '../backend/Models/authentication/DisplayUser.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  AuthController authController = AuthController();
  DisplayUser displayUser = DisplayUser();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _darkTheme = false;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  void loadUserDetails() async {
    DisplayUser user = await authController.getCurrentUser();
    setState(() {
      displayUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        _darkTheme = false;
        break;
      case Brightness.dark:
        _darkTheme = true;
        break;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: LogoAppBar(
        user: displayUser,
        scaffoldState: _scaffoldKey,
      ),
      drawer: AppDrawer(
        user: displayUser,
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(_darkTheme ? Icons.brightness_3 : Icons.brightness_4),
                Text("Dark Theme"),
              ],
            ),
            value: _darkTheme,
            onChanged: (val) {
              setState(() {
                _darkTheme = val;
                if (val) {
                  BlocProvider.of<ThemeChanger>(context)
                      .setThemeMode(ThemeMode.dark);
                } else {
                  BlocProvider.of<ThemeChanger>(context)
                      .setThemeMode(ThemeMode.light);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
