import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

//controller
import '../httpController/AuthController.dart';

//models
import '../Models/GoogleUser.dart';

enum GoogleLoginStatus{SignUp,Authenticated,Loading,UnAuthenticated}

class GoogleCubit extends Cubit<GoogleLoginStatus>{
  GoogleCubit():super(GoogleLoginStatus.UnAuthenticated);

  final AuthController _authController=AuthController();
  final GoogleSignIn _googleSignIn=GoogleSignIn(
    scopes: [
      'email'
    ]
  );
  

  void authenticate() async {
     final googleUser=await _googleSignIn.signIn();
     final googleAccount=await googleUser.authentication;
     final response=await _authController.googleUserExists(googleUser.id);
     if(response==null){
       emit(GoogleLoginStatus.SignUp);
     }else{
       GoogleUser user=GoogleUser();
       user.username=response.username;
       user.googleId=googleUser.id;
       user.accessToken=googleAccount.accessToken;
       final login=await _authController.loginGoogleUser(user);
       if(login){
         emit(GoogleLoginStatus.Authenticated);
       }else{
         emit(GoogleLoginStatus.UnAuthenticated);
       }
     }
  }

  void signOut() async{
    await _googleSignIn.signOut();
  }

}