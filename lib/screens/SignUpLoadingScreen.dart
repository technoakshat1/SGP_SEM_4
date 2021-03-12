import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//route
import './HomeScreen.dart';

//Models
import '../backend/bloc/SignUpCubit.dart';
import '../backend/bloc/GoogleCubit.dart';

//Components
import '../components/DefaultPageTransition.dart';

class SignUpLoadingScreen extends StatelessWidget {
  const SignUpLoadingScreen({Key key,this.cubit}) : super(key: key);

  final Cubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<Cubit,dynamic>(
        cubit:cubit,
        listener: (ctx,state){
          //print(state);
          if(state is SignUpStatus){
            if(state==SignUpStatus.Successfull){
              DefaultPageTransition transition=DefaultPageTransition(HomeScreen());
              Navigator.of(ctx).pushReplacement(transition.createRoute());
            }
          }
          if(state is GoogleLoginStatus){
             if(state==GoogleLoginStatus.Authenticated){
              DefaultPageTransition transition=DefaultPageTransition(HomeScreen());
              Navigator.of(ctx).pushReplacement(transition.createRoute());
            }
          }
        },
        child: Column(
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
      ),
    );
  }
}
