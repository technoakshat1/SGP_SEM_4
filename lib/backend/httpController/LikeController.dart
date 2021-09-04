import 'package:http/http.dart' as http;
import './httpMain.dart';

class LikeController extends HttpMain{
  Future<bool> hasUserLiked(postId) async {
     Uri uri=Uri.parse(super.url+"/likes/v1/hasUserLiked/$postId");
    String token = await super.storedToken;
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    
    final response=await http.get(uri,headers: headers);

    dynamic rawResponse=super.responseFieldExtractor(
      response,
      field: "liked",
      onResponseError: (_)=>false,
      onServerError: (_)=>false,
    );

    return rawResponse;
  }


  Future<bool> like(postId) async {
    Uri uri=Uri.parse(super.url+"/likes/v1/like/$postId");
    String token = await super.storedToken;
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    print(headers);
    final response=await http.get(uri,headers: headers);

    dynamic rawResponse=super.responseFieldExtractor(
      response,
      field: "liked",
      onResponseError: (_)=>false,
      onServerError: (_)=>false,
    );

    return rawResponse;

  }

  Future<bool> unlike(postId) async {
    Uri uri=Uri.parse(super.url+"/likes/v1/like/$postId");
    String token = await super.storedToken;
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };

    final response=await http.delete(uri,headers: headers);

    dynamic rawResponse=super.responseFieldExtractor(
      response,
      field: "unlike",
      onResponseError: (_)=>false,
      onServerError: (_)=>false,
    );

    return rawResponse;

  }

  Future<int> getLikes(postId) async {
    Uri uri=Uri.parse(super.url+"/likes/v1/likedBy/$postId");
    String token = await super.storedToken;
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };

    final response=await http.get(uri,headers: headers);

    dynamic likedBy=super.responseFieldExtractor(
      response,
      field: "likedBy",
      onResponseError: (_)=>null,
      onServerError: (_)=>null,
    );

    dynamic count=super.responseFieldExtractor(
      response,
      field: "count",
      onResponseError: (_)=>0,
      onServerError: (_)=>0,
    );

    return count;

  }
}