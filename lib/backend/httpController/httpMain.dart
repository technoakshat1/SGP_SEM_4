import 'dart:convert';

import 'package:http/http.dart' as http;

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
  String url = "http://192.168.43.157:3000";

  void main(){
    print(usernameAvailable("test3"));
    
  }

  Future<bool> usernameAvailable(String username) async {
    Map<String, String> body = {username: username};
    final response = await http.post(url, body: body);
    final parsedResponse=_parseResponse(response);
    
      if(!parsedResponse["error"]){
        return parsedResponse["response"]["isAvailable"];
      }
  }

  Map<dynamic, dynamic> _parseResponse(dynamic response) {
    String returedResponse = response.body;
    final castedResponse=jsonDecode(returedResponse).cast<Map<String, String>>();
    Error error;
    if(castedResponse["Error"]!=null){
      switch(castedResponse["Error"]){
        case "username_empty":
            error=Error.USERNAME_EMPTY;
            break;
        case "username_incorrect":
            error=Error.USERNAME_INCORRECT;
            break;
        case "password_empty":
             error=Error.PASSWORD_EMPTY;
             break;
        case "password_incorrect":
             error=Error.PASSWORD_INCORRECT;
             break;
        case "email_empty":
             error=Error.EMAIL_EMPTY;
             break;
        case "firstname_empty":
             error=Error.FIRSTNAME_EMPTY;        
             break;
        case "lastname_empty":
             error=Error.LASTNAME_EMPTY;
             break;
        case "JsonWebTokenError":
             error=Error.JsonWebTokenError;
             break;
      }

      dynamic transformedMap=castedResponse.map((k,v){
        if(k!="Error"){
          return MapEntry(k,v);
        }
      });
      
      return {
        response:transformedMap,
        error:error
      };

    }

  }
}
