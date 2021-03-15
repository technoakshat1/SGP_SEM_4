import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//components
import '../components/TextOnlyFieldCircular.dart';
import '../components/PasswordOnlyFieldCircular.dart';
import '../components/AccentButtonCircular.dart';
import '../components/DefaultPageTransition.dart';
import '../components/oAuthUserSignUp.dart';

//animated page import
import './SignInLoadingScreen.dart';

//blocs
import '../backend/bloc/LoginCubit.dart';
import '../backend/bloc/GoogleCubit.dart';
//models
import '../backend/Models/loginUser.dart';

// TODO :
//         3.make sign in with google working.
//         4.make continue with facebook working.
enum OAuthLoginOrSignUp { Login, SignUp }

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final LoginCubit cubitA = LoginCubit();
  final GoogleCubit cubitB = GoogleCubit();

  bool isUsernameValid = true;
  bool isPasswordValid = true;
  OAuthLoginOrSignUp status=OAuthLoginOrSignUp.Login;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validateUsername(String username) {
    if (username != null && username.length != 0) {
      setState(() {
        isUsernameValid = true;
      });
    } else {
      setState(() {
        isUsernameValid = false;
      });
    }
  }

  void validatePassword(String password) {
    if (password != null && password.length != 0) {
      setState(() {
        isPasswordValid = true;
      });
    } else {
      setState(() {
        isPasswordValid = false;
      });
    }
  }

  void localLogin() {
    String username = usernameController.text;
    String password = passwordController.text;
    if (username != null &&
        password != null &&
        username.length != 0 &&
        password.length != 0) {
      LoginUser user = LoginUser(
        username: username,
        password: password,
      );
      cubitA.login(user);
      print(user);
    } else if (username == null || username.length == 0) {
      setState(() {
        isUsernameValid = false;
      });
    } else if (password == null || password.length == 0) {
      setState(() {
        isPasswordValid = false;
      });
    }
  }

  Widget build(BuildContext context) {
    String imageAssetUri = "assets/images/logo_dark_theme.png";
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        imageAssetUri = "assets/images/logo_light_theme.png";
        break;
      case Brightness.dark:
        imageAssetUri = "assets/images/logo_dark_theme.png";
        break;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener(
          cubit: cubitB,
          listener: (ctx, state) {
            //print(state);
            if (state == GoogleLoginStatus.SignUp) {
              setState(() {
                status=OAuthLoginOrSignUp.SignUp;
              });
              showDialog(
                context: context,
                builder: (ctx) => OAuthSignUpDialog(
                  cubitA: cubitB,
                ),
              );
            } else if (state == GoogleLoginStatus.Authenticated) {
              if(status==OAuthLoginOrSignUp.Login){
                 DefaultPageTransition transition =
                  DefaultPageTransition(SignInLoadingScreen());
              Navigator.of(ctx).pushReplacement(transition.createRoute());
              }else{
                Navigator.of(ctx).pop();
              }
            }
          },
          child: BlocConsumer<LoginCubit, LoginStatus>(
            cubit: cubitA,
            listener: (ctx, state) {
              if (state == LoginStatus.Authenticated) {
                DefaultPageTransition transition =
                    DefaultPageTransition(SignInLoadingScreen());
                Navigator.of(ctx).pushReplacement(transition.createRoute());
              } else if (state == LoginStatus.PasswordIncorrect) {
                setState(() {
                  isPasswordValid = false;
                });
              } else if (state == LoginStatus.UsernameIncorrect) {
                setState(() {
                  isUsernameValid = false;
                });
              }
            },
            builder: (ctx, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 300,
                  margin: EdgeInsets.only(bottom: 0),
                  child: Image.asset(
                    imageAssetUri,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextOnlyFieldCircular(
                    textController: usernameController,
                    labelText: 'Username',
                    labelFocusColor:
                        !isUsernameValid ? Colors.red : Color(0xffaf0069),
                    labelUnfocusedColor:
                        !isUsernameValid ? Colors.red : Colors.grey,
                    onChange: validateUsername,
                  ),
                ),
                if (!isUsernameValid)
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      'Username is incorrect or empty!',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  padding: EdgeInsets.all(10),
                  child: PasswordOnlyFieldCircular(
                    textController: passwordController,
                    labelText: 'Password',
                    labelFocusColor:
                        !isPasswordValid ? Colors.red : Color(0xffaf0069),
                    labelUnfocusedColor:
                        !isPasswordValid ? Colors.red : Colors.grey,
                    onChange: validatePassword,
                  ),
                ),
                if (!isPasswordValid)
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Password is incorrect or empty!',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ),
                Container(
                  width: 300,
                  height: 40,
                  child: Stack(
                    children: [
                      Container(
                        width: 300,
                        height: 40,
                        child: AccentButtonCircular(
                          displayText: 'Login',
                          onPress: localLogin,
                        ),
                      ),
                      if (state == LoginStatus.Loading)
                        Container(
                          margin: EdgeInsets.only(left: 70, top: 5),
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            value: null,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                            strokeWidth: 3.0,
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  height: 40,
                  margin: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    onPressed: () {
                      cubitB.authenticate();
                    },
                    splashColor: Colors.black26,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Text(
                            'Sign in with Google',
                            //style: Theme.of(context).primaryTextTheme.button,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    color: Colors.red,
                  ),
                ),
                Container(
                  width: 300,
                  height: 40,
                  margin: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    onPressed: () {
                      cubitB.signOut();
                    },
                    splashColor: Colors.black26,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.white,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            'Continue with facebook',
                            //style: Theme.of(context).primaryTextTheme.button,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    color: Color(0xff1877f2),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/createKitchen');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Text(
                      'Create Kitchen ?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
