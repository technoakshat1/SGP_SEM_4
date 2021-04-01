import 'package:flutter/material.dart';

//screens
import 'screens/authentication/SignInScreen.dart';
import 'screens/authentication/SignUpScreen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitchen Cloud',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Color(0XFF397031),
        primaryColorLight: Color(0xff679f5c),
        primaryColorDark: Color(0xff054407),
        accentColor: Color(0xfff6c065),
        primaryTextTheme: TextTheme(
          button: TextStyle(color: Colors.black,fontSize:18),
          headline5: TextStyle(color: Colors.black),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
        primaryColor: Color(0XFF397031),
        primaryColorLight: Color(0xff679f5c),
        primaryColorDark: Color(0xff054407),
        accentColor: Color(0xfff6c065),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(
          button: TextStyle(color: Colors.black,fontSize:18),
          headline5: TextStyle(color:Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      routes: {
        '/':(context)=>SignInScreen(),
        '/createKitchen':(context)=>SignUpScreen(),
        
      },
    );
  }
}
