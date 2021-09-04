import './OAuthUser.dart';

class GoogleUser extends OAuthUser {
  String accessToken;
  String googleId;
  String photoUrl;
  String username;
  String email;
  String displayName;

  @override
  String toString() {
    return "{accessToken:$accessToken,googleId:$googleId,photoUrl:$photoUrl,username:$username,email:$email,displayName:$displayName}";
  }
}
