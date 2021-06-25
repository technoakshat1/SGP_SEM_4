import "package:bloc/bloc.dart";
import '../Models/authentication/DisplayUser.dart';
import "../httpController/AuthController.dart";

enum DisplayUserStatus{Loading,Available,UnAvailable}

class DisplayUserCubit extends Cubit{
  
  DisplayUserCubit():super({});

  AuthController controller=AuthController();
  DisplayUser user;

  void getUserDetails(String username) async {
      user=await controller.getUserDetails(username);
      if(user!=null){
        //print(user.photoUrl);
        emit({"displayUser":user,"status":DisplayUserStatus.Available});
      }else{
        emit({"displayUser":null,"status":DisplayUserStatus.UnAvailable});
      }
  }

  void emitStoredUser() {
    if(user!=null){
        emit({"displayUser":user,"status":DisplayUserStatus.Available});
      }else{
        emit({"displayUser":null,"status":DisplayUserStatus.UnAvailable});
      }
  }

}