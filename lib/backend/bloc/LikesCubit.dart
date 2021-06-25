import 'package:bloc/bloc.dart';
import '../httpController/LikeController.dart';

class LikesCubit extends Cubit{
  LikesCubit():super({"count":0});

  LikeController controller=LikeController();
  var likes;
  
  void getLikes(String postId) async {
    likes=await controller.getLikes(postId);
    emit(likes);
  }

  void hasUserLiked(String postId) async {
    bool liked=await controller.hasUserLiked(postId);
    emit({"liked":liked,...likes});
  }


  void like(String postId) async {
    bool liked=await controller.like(postId);
    emit({"liked":liked});
  }

  void unlike(String postId) async {
    bool unliked=await controller.unlike(postId);
    emit({"liked":!unliked});
  }

}