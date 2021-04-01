import 'package:bloc/bloc.dart';

//Models
import '../Models/authentication/loginUser.dart';

//controllers
import '../httpController/AuthController.dart';
import '../httpController/httpMain.dart';

enum LoginStatus {
  unAuthenticated,
  Authenticated,
  Loading,
  UsernameIncorrect,
  PasswordIncorrect
}

class LoginCubit extends Cubit<LoginStatus> {
  LoginCubit() : super(LoginStatus.Authenticated);

  AuthController controller = new AuthController();

  void login(LoginUser user) async {
    emit(LoginStatus.Loading);
    var response = await Future.delayed(
        Duration(milliseconds: 2000), () => controller.login(user));

    if (response is bool) {
      if (response) {
        emit(LoginStatus.Authenticated);
      } else {
        emit(LoginStatus.unAuthenticated);
      }
    } else if (response is Error) {
      if (response == Error.USERNAME_INCORRECT) {
        emit(LoginStatus.UsernameIncorrect);
      } else if (response == Error.PASSWORD_INCORRECT) {
        emit(LoginStatus.PasswordIncorrect);
      }
    }
  }
}
