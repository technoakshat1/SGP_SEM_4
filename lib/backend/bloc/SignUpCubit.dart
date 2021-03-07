import 'package:bloc/bloc.dart';

//Controllers
import '../httpController/AuthController.dart';

//Models
import '../Models/SignUpUser.dart';

enum SignUpStatus { Successfull, UnSuccessfull, Loading, Pending }
enum UsernameAvailability{Available,UnAvailable,Loading}

class SignUpCubit extends Cubit<dynamic> {
  SignUpCubit() : super(SignUpStatus.Pending);

  AuthController controller = AuthController();

  void signUp(SignUpUser user) async {
    emit(SignUpStatus.Loading);
    bool response = await Future.delayed(Duration(seconds: 3),()=>controller.signUp(user));
    if(response){
      emit(SignUpStatus.Successfull);
    }else{
      emit(SignUpStatus.UnSuccessfull);
    }
  }

  void usernameAvailable(String username) async {
    emit(UsernameAvailability.Loading);
    bool response =await controller.usernameAvailable(username);
    if(response){
      emit(UsernameAvailability.Available);
    }else{
      emit(UsernameAvailability.UnAvailable);
    }
  }

}
