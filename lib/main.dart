import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/screens/HomeScreen.dart';

//blocs
import './backend/bloc/LoginCubit.dart';

//screens
import 'screens/authentication/SignInScreen.dart';
import 'screens/authentication/SignUpScreen.dart';
import './screens/authentication/WelcomeScreen.dart';

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
          button: TextStyle(color: Colors.black, fontSize: 18),
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
          button: TextStyle(color: Colors.black, fontSize: 18),
          headline5: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      // home:HomeScreen(),
      home: BlocProvider(
        create: (ctx){
          LoginCubit cubit=LoginCubit();
          cubit.isAuthenticated();
          return cubit;
        },
        child: WelcomeScreen(),
      ),
      routes: {
        '/login': (context) => SignInScreen(),
        '/createKitchen': (context) => SignUpScreen(),
      },
    );
  }
}
