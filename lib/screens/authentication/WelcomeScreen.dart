import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//bloc
import '../../backend/bloc/LoginCubit.dart';
//animation
import '../../components/animatedRoutes/DefaultPageTransition.dart';
import '../authentication/SignInLoadingScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageAssetUri = "assets/images/logo_dark_theme.png";
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        imageAssetUri = "assets/images/logo_light_theme.png";
        break;
      case Brightness.dark:
        imageAssetUri = "assets/images/logo_dark_theme.png";
        break;
    }
    return Scaffold(
      body: BlocListener<LoginCubit, LoginStatus>(
        listener: (ctx, state) {
          if (state == LoginStatus.Authenticated) {
            DefaultPageTransition transition =
                DefaultPageTransition(SignInLoadingScreen());
            Navigator.of(ctx).pushReplacement(transition.createRoute());
          } else {
            Navigator.of(ctx).pushReplacementNamed('/login');
          }
        },
        child:Container(
          margin:EdgeInsets.only(left:5),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 400,
                margin: EdgeInsets.only(bottom: 0),
                child: Image.asset(
                  imageAssetUri,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Text(
                  'Welcome to Kitchen Cloud!',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin:EdgeInsets.all(30),
                child: CircularProgressIndicator(
                  value: null,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor,
                  ),
                  strokeWidth: 3.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
