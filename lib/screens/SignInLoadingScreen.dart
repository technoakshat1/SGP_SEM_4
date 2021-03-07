import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignInLoadingScreen extends StatelessWidget {
  const SignInLoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset('assets/animation/loading_screen_animation.json'),
          Container(
            child: Text(
              'yay! time to cook something delicious',
              style:TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
