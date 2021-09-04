import 'package:bloc/bloc.dart';

import './OAuthInterface.dart';

//controller
import '../httpController/AuthController.dart';

//models
import '../Models/authentication/GoogleUser.dart';

enum GoogleLoginStatus { SignUp, Authenticated, Loading, UnAuthenticated }

class GoogleCubit extends Cubit<dynamic> implements OAuthInterface {
  GoogleCubit() : super(GoogleLoginStatus.UnAuthenticated);

  final AuthController _authController = AuthController();
  GoogleUser user = GoogleUser();

  void logout() {
    //_googleSignIn.signOut();
  }

  void login(bool created, String username, String googleId,
      String accessToken) async {
    emit(GoogleLoginStatus.Loading);
    user.googleId = googleId;
    user.accessToken = accessToken;
    if (created) {
      emit(GoogleLoginStatus.SignUp);
    } else {
      try {
        user.username = username;
        if (await _authController.loginGoogleUser(user)) {
          emit(GoogleLoginStatus.Authenticated);
        } else {
          emit(GoogleLoginStatus.UnAuthenticated);
        }
      } catch (e, s) {
        print('login error: $e - stack: $s');
        emit(GoogleLoginStatus.UnAuthenticated);
      }
    }
  }

  void authenticate() async {
    //print(googleUser.id);
  }

  void signUp(String username) async {
    emit(GoogleLoginStatus.Loading);
    user.username = username;
    print(user);
    final response = await _authController.signUpGoogleUser(user);
    if (response) {
      emit(GoogleLoginStatus.Authenticated);
    } else {
      emit(GoogleLoginStatus.UnAuthenticated);
    }
  }

  void signOut() async {
    //await _googleSignIn.signOut();
  }
}
