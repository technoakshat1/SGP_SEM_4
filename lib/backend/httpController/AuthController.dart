import 'package:http/http.dart' as http;

//parent
import './httpMain.dart';

//models
import '../Models/authentication/loginUser.dart';
import '../Models/authentication/SignUpUser.dart';
import '../Models/authentication/GoogleUser.dart';
import '../Models/authentication/FacebookUser.dart';
import "../Models/authentication/DisplayUser.dart";

class AuthController extends HttpMain {
  String authUrl;

  AuthController() {
    authUrl = super.url + "/auth/v1";
  }

  Future<DisplayUser> getCurrentUser() async {
    Uri uri = Uri.parse(authUrl +
        "/user?details=username&details=photoUrl&details=displayName");
    String token = await super.storedToken;
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    dynamic response = await http.get(uri, headers: headers);
    dynamic rawResponse = super.responseFieldExtractor(
      response,
      field: "user",
      onResponseError: (_) => null,
      onServerError: (_) => null,
    );

    DisplayUser user = DisplayUser();

    //print(rawResponse['photoUrl']);

    user.username = rawResponse['username'];
    user.photoUrl = rawResponse['photoUrl'];
    user.displayName = rawResponse['displayName'];
    return user;
  }

  Future<DisplayUser> getUserDetails(String username) async {
    Uri uri = Uri.parse(authUrl +
        "/user/$username?details=username&details=photoUrl&details=displayName");
    String token = await super.storedToken;
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    dynamic response = await http.get(uri, headers: headers);
    dynamic rawResponse = super.responseFieldExtractor(
      response,
      field: "user",
      onResponseError: (_) => null,
      onServerError: (_) => null,
    );

    DisplayUser user = DisplayUser();

    //print(rawResponse['photoUrl']);

    user.username = rawResponse['username'];
    user.photoUrl = rawResponse['photoUrl'];
    user.displayName = rawResponse['displayName'];
    return user;
  }

  Future<bool> isAuthenticated() async {
    String token = await super.storedToken;
    Uri uri = Uri.parse(authUrl + "/login");

    Map<String, String> header = {"Authorization": "Bearer $token"};
    final response = await http.get(uri, headers: header);
    return super.responseFieldExtractor(
      response,
      field: 'authenticated',
      onResponseError: (error) => false,
      onServerError: (_) => false,
    );
  }

  Future<dynamic> login(LoginUser user) async {
    Uri uri = Uri.parse(authUrl + "/local/login");

    Map<String, String> body = {
      'username': user.username,
      'password': user.password
    };
    Error error;
    final response = await http.post(uri, body: body);
    String token = super.responseFieldExtractor(response,
        field: 'token',
        onResponseError: (err) {
          error = err;
          return null;
        },
        onServerError: (_) => null);
    if (token != null) {
      await super.setToken(token);
      return true;
    } else if (error != null) {
      return error;
    }

    return false;
  }

  Future<bool> logout() async {
    return await super.removeToken();
  }

  Future<bool> usernameAvailable(String username) async {
    //print(body);
    Uri uri = Uri.parse(authUrl + "/username_available/" + username);
    final response = await http.get(uri);
    return super.responseFieldExtractor(response,
        field: 'isAvailable',
        onResponseError: (_) => false,
        onServerError: (_) => false);
  }

  Future<bool> signUp(SignUpUser user) async {
    Map<String, String> body = {
      'username': user.username,
      'password': user.password,
      'email': user.email,
      'firstName': user.firstName,
      'lastName': user.lastName
    };

    Uri uri = Uri.parse(authUrl + "/local/signUp");
    final response = await http.post(uri, body: body);
    String token = super.responseFieldExtractor(response,
        field: "token",
        onResponseError: (_) => null,
        onServerError: (_) => null);
    if (token != null) {
      await super.removeToken();
      await super.setToken(token);
      return true;
    }
    return false;
  }

  Future<GoogleUser> googleUserExists(String id) async {
    Uri uri = Uri.parse(authUrl + "/google/" + id);
    final response = await http.get(uri);
    bool exists = super.responseFieldExtractor(response,
        field: 'exists',
        onResponseError: (_) => false,
        onServerError: (_) => false);
    if (exists) {
      GoogleUser user = GoogleUser();
      user.username = super.responseFieldExtractor(
        response,
        field: 'username',
        onResponseError: (_) => null,
        onServerError: (_) => null,
      );
      return user;
    }
    return null;
  }

  Future<bool> signUpGoogleUser(GoogleUser user) async {
    Map<String, String> body = {
      'username': user.username,
      'token': user.accessToken,
      'googleId': user.googleId,
    };

    Uri uri = Uri.parse(authUrl + "/google/username");
    //print(uri);
    final response = await http.post(uri, body: body);
    String token = super.responseFieldExtractor(
      response,
      field: 'token',
      onResponseError: (_) => null,
      onServerError: (_) => null,
    );

    if (token != null) {
      return await super.setToken(token);
    }
    return false;
  }

  Future<bool> loginGoogleUser(GoogleUser user) async {
    Map<String, String> body = {
      'username': user.username,
      'googleId': user.googleId,
      'token': user.accessToken,
    };
    //print(isTokenValid);
    Uri uri = Uri.parse(authUrl + "/google/login");
    final response = await http.post(uri, body: body);
    String token = super.responseFieldExtractor(response,
        field: 'token',
        onResponseError: (_) => null,
        onServerError: (_) => null);
    if (token != null) {
      await super.setToken(token);
      return true;
    }

    return false;
  }

  Future<FacebookUser> facebookUserExists(String id) async {
    Uri uri = Uri.parse(authUrl + "/facebook/" + id);
    final response = await http.get(uri);
    bool exists = super.responseFieldExtractor(
      response,
      field: 'exists',
      onResponseError: (_) => false,
      onServerError: (_) => false,
    );
    if (exists) {
      FacebookUser user = FacebookUser();
      user.username = super.responseFieldExtractor(
        response,
        field: 'username',
        onResponseError: (_) => null,
        onServerError: (_) => null,
      );
      return user;
    }
    return null;
  }

  Future<bool> signUpFacebookUser(FacebookUser user) async {
    Map<String, String> body = {
      'username': user.username,
      'photoUrl': user.photoUrl != null ? user.photoUrl : 'photoUrl',
      'accessToken': user.accessToken,
      'facebookId': user.facebookId,
      'displayName': user.name,
      'email': user.email,
    };

    Uri uri = Uri.parse(authUrl + "/facebook/signUp");
    //print(uri);
    final response = await http.post(uri, body: body);
    String token = super.responseFieldExtractor(
      response,
      field: 'token',
      onResponseError: (_) => null,
      onServerError: (_) => null,
    );

    if (token != null) {
      return await super.setToken(token);
    }
    return false;
  }

  Future<bool> loginFacebookUser(FacebookUser user) async {
    //final isTokenValid = await _isFacebookAccessTokenValid(user.accessToken);
    Map<String, String> body = {
      'username': user.username,
      'facebookId': user.facebookId,
      'accessToken': user.accessToken,
    };
    print(body);

    Uri uri = Uri.parse(authUrl + "/facebook/login");
    final response = await http.post(uri, body: body);
    String token = super.responseFieldExtractor(response,
        field: 'token',
        onResponseError: (_) => null,
        onServerError: (_) => null);
    if (token != null) {
      await super.setToken(token);
      return true;
    }

    return false;
  }
}
