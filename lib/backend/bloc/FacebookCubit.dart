import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../Models/authentication/FacebookUser.dart';
import 'package:recipe_app/backend/httpController/AuthController.dart';
import 'package:http/http.dart' as http;

import 'OAuthInterface.dart';

enum FacebookAuthStatus{SignUp,Authenticated,Loading,UnAuthenticated,LogOut}


class FacebookCubit extends Cubit<dynamic> implements OAuthInterface{

  FacebookCubit() : super(FacebookAuthStatus.UnAuthenticated);
  final AuthController _authController=AuthController();
  final FacebookLogin _facebookLogin=FacebookLogin();
  FacebookUser user=FacebookUser();


  void authenticate() async{
    final facebookUser=await _facebookLogin.logIn(['email']);
    switch(facebookUser.status){
      case FacebookLoginStatus.error:
        print("Error");
        emit(FacebookAuthStatus.UnAuthenticated);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled By User");
        emit(FacebookAuthStatus.UnAuthenticated);
        break;
      case FacebookLoginStatus.loggedIn:

        print("Logged In");
        print(facebookUser.accessToken);
        var token=facebookUser.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,id,email&access_token=$token');
        final profile=json.decode(graphResponse.body);

        final response=await _authController.facebookUserExists(profile['id']);

        if(response==null){
          user.accessToken=token;
          user.name=profile['name'];
          user.photoUrl=profile['picture']['data']['url'];
          user.email=profile['email'];
          user.facebookId=profile['id'];
          //print("User Nai hai re baba");
          emit(FacebookAuthStatus.SignUp);
        }
        else{
          user.username=response.username;
          user.name=profile['name'];
          user.facebookId=profile['id'];
          user.accessToken=token;
          //print("USer hai re baba");
          final login = await _authController.loginFacebookUser(user);
          print(login);
          if (login) {
            emit(FacebookAuthStatus.Authenticated);
          } else {
            emit(FacebookAuthStatus.UnAuthenticated);
          }
        }
        break;
    }
  }
  void signUp(String username) async {
    emit(FacebookAuthStatus.Loading);
    user.username=username;
    final response=await _authController.signUpFacebookUser(user);
    if(response){
      emit(FacebookAuthStatus.Authenticated);
    }else{
      emit(FacebookAuthStatus.UnAuthenticated);
    }
  }
  void logOut() async{
    await _authController.logout();
    await _facebookLogin.logOut();
    emit(FacebookAuthStatus.LogOut);
  }
}
