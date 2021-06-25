import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../backend/bloc/PostsCubit.dart';
import "../../components/animatedRoutes/DefaultPageTransition.dart";
import "../HomeScreen.dart";

class SignInLoadingScreen extends StatelessWidget {
  SignInLoadingScreen({Key key}) : super(key: key);

  final PostsCubit cubit = PostsCubit();

  @override
  Widget build(BuildContext context) {
    DefaultPageTransition transition = DefaultPageTransition(HomeScreen());
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(transition.createRoute());
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset('assets/animation/loading_screen_animation.json'),
          Container(
            child: Text(
              'yay! time to cook something delicious',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
