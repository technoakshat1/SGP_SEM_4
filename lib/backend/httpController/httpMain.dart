import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

enum Error {
  USERNAME_DUPLICATE,
  USERNAME_EMPTY,
  USERNAME_INCORRECT,
  PASSWORD_INCORRECT,
  PASSWORD_EMPTY,
  FIRSTNAME_EMPTY,
  LASTNAME_EMPTY,
  EMAIL_EMPTY,
  JsonWebTokenError,
}

class HttpMain {
  static const String pcIpv4 = "192.168.43.157"; //your device IP
  String url = 'http://$pcIpv4:3000';
  static const String TOKEN = "TOKEN";
  
  Future<String> get storedToken async{
     final SharedPreferences prefs=await SharedPreferences.getInstance();
     return prefs.getString(TOKEN);
  }

  Future<bool> setToken(String token) async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.setString(TOKEN, token);
  }

  Future<bool> removeToken() async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
   return await prefs.remove(TOKEN);
  }

  Map<dynamic, dynamic> _parseResponse(dynamic res) {
    String returedResponse = res.body;
    //print(res.body);
    final castedResponse = jsonDecode(returedResponse);
    //print(castedResponse);
    Error error;
    if (castedResponse["Error"] != null) {
      switch (castedResponse["Error"]) {
        case "username_empty":
          error = Error.USERNAME_EMPTY;
          break;
        case "username_incorrect":
          error = Error.USERNAME_INCORRECT;
          break;
        case "password_empty":
          error = Error.PASSWORD_EMPTY;
          break;
        case "password_incorrect":
          error = Error.PASSWORD_INCORRECT;
          break;
        case "email_empty":
          error = Error.EMAIL_EMPTY;
          break;
        case "firstname_empty":
          error = Error.FIRSTNAME_EMPTY;
          break;
        case "lastname_empty":
          error = Error.LASTNAME_EMPTY;
          break;
        case "JsonWebTokenError":
          error = Error.JsonWebTokenError;
          break;
        case "username_duplicate":
           error=Error.USERNAME_DUPLICATE;
           break;
      }

      return {"error": error};
    }
    return {
      "response": castedResponse,
    };
  }

  dynamic responseFieldExtractor(dynamic response,
      {String field,
      Function onResponseError,
      Function onServerError}) {
    if (response.statusCode == 200) {
      final parsedResponse = _parseResponse(response);
      if (parsedResponse["error"] == null) {
        //print(parsedResponse['response']);
        return parsedResponse['response'][field];
      } else {
        return onResponseError(parsedResponse['error']);
      }
    } else {
      return onServerError(response.statusCode);
    }
  }
}
