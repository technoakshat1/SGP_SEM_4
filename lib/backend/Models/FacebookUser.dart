import 'package:recipe_app/backend/Models/OAuthUser.dart';

import './OAuthUser.dart'; 

class FacebookUser extends OAuthUser{
  String accessToken;
  String name;
  String email;
  String photoUrl;
  String username;
  String facebookId;
}