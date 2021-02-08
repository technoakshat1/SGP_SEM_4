import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignUpLoadingScreen extends StatelessWidget {
  const SignUpLoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset('assets/animation/loading_animation_1.json'),
          Text(
            'Welcome to Kitchen Cloud wait until our Chef sets up your kitchen!',
            style:TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
