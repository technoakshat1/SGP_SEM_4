import './OAuthUser.dart';

class GoogleUser extends OAuthUser {
  String accessToken;
  String googleId;
  String photoUrl;
  String username;
  String email;
  String displayName;
}