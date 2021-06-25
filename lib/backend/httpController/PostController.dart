import 'package:http/http.dart' as http;
import './httpMain.dart';
import '../Models/post/post.dart';

class PostController extends HttpMain {
  String postUrl;
  PostController() {
    postUrl = super.url + "/posts/v1";
  }

  Future<List> getPostByUserId(String userId) async {
    String uri=postUrl+"/post/"+userId;
    return await _parseRequestAndGetPosts(uri);
  }

  Future<List> getPosts() async {
    String uri = postUrl + "/posts";
    return await _parseRequestAndGetPosts(uri);
  }

  Future<List> getPostsByQuery(String query) async {
    String uri = postUrl + "/posts?q=$query";
    return await _parseRequestAndGetPosts(uri);
  }

  Future<List> getPostsByCategories(Categories category) async {
    String cat = _mapCategoryToString(category);
    String uri = postUrl + "/posts?cat=$cat";
    return await _parseRequestAndGetPosts(uri);
  }

  Future<List> getPostsByCategoryAndFilters(
      Categories category, List<Filters> filters) async {
    String cat = _mapCategoryToString(category);
    List<String> stringFilters = List.empty(growable: true);
    for (int i = 0; i < filters.length; i++) {
      stringFilters.add(_mapFilterToString(filters[i]));
    }

    Uri uri = Uri(
        scheme: "http",
        host: HttpMain.pcIpv4,
        port: 3000,
        path: "/posts/v1/posts",
        queryParameters: {
          if (cat != null) "cat": cat,
          "filter": Iterable.castFrom(stringFilters),
        });

    //print(uri);

    List response = await _parseRequestAndGetPosts(uri);
    //print(response[0]);
    return response;
  }

  String _mapCategoryToString(Categories category) {
    switch (category) {
      case Categories.ALL:
        return "All";
      case Categories.BREAKFAST:
        return "Breakfast";
      case Categories.BRUNCH:
        return "Brunch";
      case Categories.DINNER:
        return "Dinner";
      case Categories.HIGH_TEA:
        return "High_Tea";
      case Categories.LUNCH:
        return "Lunch";
    }
    return null;
  }

  String _mapFilterToString(Filters filter) {
    switch (filter) {
      case Filters.ALL:
        return "All";
      case Filters.DIET:
        return "Diet";
      case Filters.FASTING:
        return "Fasting";
      case Filters.FESTIVE:
        return "Festive";
      case Filters.JAIN:
        return "Jain";
      case Filters.LOW_SALT:
        return "Low_Salt";
      case Filters.NON_VEG:
        return "Non_Veg";
      case Filters.PROBIOTIC:
        return "Probiotic";
      case Filters.VEG:
        return "Veg";
      case Filters.DIET:
        return "Diet";
    }
    return null;
  }

  Future<List> _parseRequestAndGetPosts(dynamic uri) async {
    String token = await super.storedToken;
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };

    List<Post> posts = List.empty(growable: true);

    dynamic response = await http.get(uri, headers: headers);

    int count = super.responseFieldExtractor(
      response,
      field: 'count',
      onResponseError: (_) => 0,
      onServerError: (_) => 0,
    );

    dynamic rawPosts = super.responseFieldExtractor(
      response,
      field: 'posts',
      onResponseError: (_) => null,
      onServerError: (_) => null,
    );

    //print(rawPosts[0]['categories'] is List);

    for (int i = 0; i < count && count > 0; i++) {
      Post post = new Post();
      post.parseAndInflatePost(rawPosts[i]);
      posts.add(post);
    }
    return posts;
  }
}
