import 'package:bloc/bloc.dart';

abstract class OAuthInterface implements Cubit{
  void signUp(String username);
  void authenticate();
}