import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

//controller
import '../httpController/AuthController.dart';

//models
import '../Models/GoogleUser.dart';

enum GoogleLoginStatus { SignUp, Authenticated, Loading, UnAuthenticated }

class GoogleCubit extends Cubit<GoogleLoginStatus> {
  GoogleCubit() : super(GoogleLoginStatus.UnAuthenticated);

  final AuthController _authController = AuthController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleUser user = GoogleUser();

  void authenticate() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final googleAccount = await googleUser.authentication;
      final response = await _authController.googleUserExists(googleUser.id);
      if (response == null) {
        user.googleId = googleUser.id;
        user.accessToken=googleAccount.accessToken;
        user.photoUrl=googleUser.photoUrl;
        user.email=googleUser.email;
        user.displayName=googleUser.displayName;
        emit(GoogleLoginStatus.SignUp);
      } else {
        user.username = response.username;
        user.googleId = googleUser.id;
        user.accessToken = googleAccount.accessToken;
        final login = await _authController.loginGoogleUser(user);
        if (login) {
          emit(GoogleLoginStatus.Authenticated);
        } else {
          emit(GoogleLoginStatus.UnAuthenticated);
        }
      }
    }
    emit(GoogleLoginStatus.UnAuthenticated);
  }

  void signUp(String username) async {
    emit(GoogleLoginStatus.Loading);
    user.username=username;
    final response=await _authController.signUpGoogleUser(user);
    if(response){
       emit(GoogleLoginStatus.Authenticated);
    }else{
      emit(GoogleLoginStatus.UnAuthenticated);
    }
  }

  void signOut() async {
    await _googleSignIn.signOut();
  }
}
