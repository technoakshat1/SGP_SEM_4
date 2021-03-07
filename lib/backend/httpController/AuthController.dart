import 'package:http/http.dart' as http;

//parent
import './httpMain.dart';

//models
import '../Models/loginUser.dart';
import '../Models/SignUpUser.dart';

class AuthController extends HttpMain {
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
          error=err;
          return null;
        },
        onServerError: (_) => null);
    if (token != null) {
      await super.setToken(token);
      return true;
    }else if(error!=null){
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
    String token = super.responseFieldExtractor(
      response,
      field: "token",
      onResponseError: (_)=>null,
      onServerError: (_) =>null
    );
    print(token);
    if(token!=null){
       await super.removeToken();
       await super.setToken(token);
       return true;
    }
    return false;
  }
}
