import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//parent
import './httpMain.dart';

//models
import '../Models/loginUser.dart';
import '../Models/SignUpUser.dart';
import '../Models/GoogleUser.dart';

class AuthController extends HttpMain {
  static const String GOOGLE_ACCESS_TOKEN = "GOOGLE_ACCESS_TOKEN";

  Future<dynamic> isAuthenticated() async {
    String token = await super.storedToken;
    String uri = super.url + "/login";

    Map<String, String> header = {"Authorization": "Bearer $token"};
    final response = await http.get(uri, headers: header);
    return super.responseFieldExtractor(
      response,
      field: 'authenticated',
      onResponseError: (error) => error,
      onServerError: (_) => false,
    );
  }

  Future<dynamic> login(LoginUser user) async {
    String uri = super.url + "/login";

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
    Map<String, String> body = {'username': username};
    //print(body);
    String uri = super.url + "/username_available";
    final response = await http.post(uri, body: body);
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

    String uri = super.url + "/signUp";
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
    Map<String, String> body = {'googleId': id};
    String uri = super.url + "/google_user_exists";
    final response = await http.post(uri, body: body);
    bool exists = super.responseFieldExtractor(response,
        field: 'exists',
        onResponseError: (_) => false,
        onServerError: (_) => false);
    if (exists) {
      GoogleUser user = GoogleUser();
      user.username = super.responseFieldExtractor(
        response,
        field: 'username',
        onResponseError: (_)=>null,
        onServerError: (_)=>null,
      );
      return user;
    }
    return null;
  }

  Future<bool> signUpGoogleUser(GoogleUser user) async {
    Map<String, String> body = {
      'username': user.username,
      'photoUrl': user.photoUrl!=null?user.photoUrl:'photoUrl',
      'accessToken': user.accessToken,
      'googleId': user.googleId,
      'displayName':user.displayName,
       'email':user.email,
    };

    String uri = super.url + "/signUp/googleUser";
    print(uri);
    final response = await http.post(uri, body: body);
    String token = super.responseFieldExtractor(
      response,
      field: 'token',
      onResponseError: (_) => null,
      onServerError: (_) => null,
    );

    if (token != null) {
      await _storeGoogleAccessToken(user.accessToken);
      return await super.setToken(token);
    }
    return false;
  }

  Future<bool> _isGoogleAccessTokenValid(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedToken = prefs.getString(GOOGLE_ACCESS_TOKEN);

    if (storedToken != null) {
      return token == storedToken;
    } else {
      return false;
    }
  }

  Future<void> _storeGoogleAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(GOOGLE_ACCESS_TOKEN, token);
  }

  Future<bool> _refreshGoogleAccessToken(GoogleUser user) async {
    Map<String, String> body = {
      'username': user.username,
      'googleId': user.googleId,
      'accessToken': user.accessToken,
    };

    String token = await super.storedToken;

    Map<String, String> header = {'Authorization': 'Bearer $token'};

    String uri = super.url + "/login/refresh_google_access_token";

    final response = await http.post(uri, body: body, headers: header);

    bool refresed = super.responseFieldExtractor(
      response,
      field: 'refreshedToken',
      onResponseError: (_) => false,
      onServerError: (_) => false,
    );

    if (refresed) {
      await _storeGoogleAccessToken(user.accessToken);
      return true;
    }

    return false;
  }

  Future<bool> loginGoogleUser(GoogleUser user) async {
    final isTokenValid = await _isGoogleAccessTokenValid(user.accessToken);
    Map<String, String> body = {
      'username': user.username,
      'googleId': user.googleId,
      'accessToken': user.accessToken,
    };
    //print(isTokenValid);
    if (isTokenValid) {
      String uri = super.url + "/login/googleUser";
      final response = await http.post(uri, body: body);
      String token = super.responseFieldExtractor(response,
          field: 'token',
          onResponseError: (_) => null,
          onServerError: (_) => null);
      if (token != null) {
        await super.setToken(token);
        return true;
      }
    } else {
      final refreshedToken = await _refreshGoogleAccessToken(user);
      //print(refreshedToken);
      if (refreshedToken) {
        String uri = super.url + "/login/googleUser";
        final response = await http.post(uri, body: body);
        String token = super.responseFieldExtractor(response,
            field: 'token',
            onResponseError: (_) => null,
            onServerError: (_) => null);
        if (token != null) {
          await super.setToken(token);
          return true;
        }
      }
    }
    return false;
  }
}
