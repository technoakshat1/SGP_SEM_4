import 'package:bloc/bloc.dart';
import '../httpController/PostController.dart';
import '../Models/post/post.dart';

enum PostStatus{Loading,Available,UnAvailable}

class PostsCubit extends Cubit<Map<String,dynamic>>{
  PostsCubit():super({'post':null,'count':0,'status':PostStatus.UnAvailable});
  
  List<Post> posts=List.empty();
  PostController controller=PostController();
  

  void getPosts() async {
    emit({'status':PostStatus.Loading});
    posts=await controller.getPosts();
    if(posts !=null && posts.length>0){
      emit({'posts':posts,'count':posts.length,'status':PostStatus.Available});
    }else{
      emit({"posts":null,"count":0,"status":PostStatus.UnAvailable});
    }
  }

  void emitStoredPosts() {
    if(posts !=null && posts.length>0){
      emit({"posts":posts,"count":posts.length,"status":PostStatus.Available});
    }else{
      emit({"posts":null,"count":0,"status":PostStatus.UnAvailable});
    }
  }

}