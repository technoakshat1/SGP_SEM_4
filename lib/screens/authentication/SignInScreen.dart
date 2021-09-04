import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:recipe_app/backend/bloc/FacebookCubit.dart';

//components
import '../../components/authentication/statefulWidgets/TextOnlyFieldCircular.dart';
import '../../components/authentication/statefulWidgets/PasswordOnlyFieldCircular.dart';
import '../../components/authentication/statelessWidgets/AccentButtonCircular.dart';
import '../../components/AnimatedRoutes/DefaultPageTransition.dart';
import '../../components/authentication/statefulWidgets/oAuthUserSignUp.dart';

//animated page import
import 'SignInLoadingScreen.dart';

//blocs
import '../../backend/bloc/LoginCubit.dart';
import '../../backend/bloc/GoogleCubit.dart';
//models
import '../../backend/Models/authentication/loginUser.dart';

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
  final FacebookCubit cubitC = FacebookCubit();

  bool isUsernameValid = true;
  bool isPasswordValid = true;
  OAuthLoginOrSignUp status = OAuthLoginOrSignUp.Login;

  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink.link;

      if (deepLink != null) {
        print("Data of link is " + deepLink.query);
        print(deepLink.queryParameters['created']);

        bool created =
            deepLink.queryParameters['created'] == 'true' ? true : false;
        String username = deepLink.queryParameters['username'];
        String googleId = deepLink.queryParameters['googleId'];
        String accessToken = deepLink.queryParameters["token"];

        cubitB.login(created, username, googleId, accessToken);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      final Uri deepLink = data.link;

      if (deepLink != null) {
        print(deepLink.data);
        //Navigator.pushNamed(context, deepLink.path);
      }
    } else {
      print("No intial link");
    }
  }

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
        child: MultiBlocListener(
          listeners: [
            BlocListener<FacebookCubit, dynamic>(
              bloc: cubitC,
              listener: (ctx, state) {
                if (state == FacebookAuthStatus.SignUp) {
                  setState(() {
                    status = OAuthLoginOrSignUp.SignUp;
                  });
                  showDialog(
                    context: context,
                    builder: (ctx) => OAuthSignUpDialog(
                      cubit: cubitC,
                    ),
                  );
                } else if (state == FacebookAuthStatus.Authenticated) {
                  if (status == OAuthLoginOrSignUp.Login) {
                    DefaultPageTransition transition =
                        DefaultPageTransition(SignInLoadingScreen());
                    Navigator.of(ctx).pushReplacement(transition.createRoute());
                  } else {
                    Navigator.of(ctx).pop();
                  }
                }
              },
            ),
            BlocListener<GoogleCubit, dynamic>(
              bloc: cubitB,
              listener: (ctx, state) {
                //print(state);
                if (state == GoogleLoginStatus.SignUp) {
                  setState(() {
                    status = OAuthLoginOrSignUp.SignUp;
                  });
                  showDialog(
                    context: context,
                    builder: (ctx) => OAuthSignUpDialog(
                      cubit: cubitB,
                    ),
                  );
                } else if (state == GoogleLoginStatus.Authenticated) {
                  if (status == OAuthLoginOrSignUp.Login) {
                    DefaultPageTransition transition =
                        DefaultPageTransition(SignInLoadingScreen());
                    Navigator.of(ctx).pushReplacement(transition.createRoute());
                  } else {
                    Navigator.of(ctx).pop();
                  }
                }
              },
            )
          ],
          child: BlocConsumer<LoginCubit, LoginStatus>(
            bloc: cubitA,
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
                  child: ElevatedButton(
                    onPressed: () async {
                      await launch(
                          'http://192.168.43.157:8000/auth/v1/web/google');
                    },
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
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.black26),
                      shape: MaterialStateProperty.resolveWith<
                          RoundedRectangleBorder>(
                        (state) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.red),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 40,
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      cubitC.authenticate();
                    },
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
                            'Continue with Facebook',
                            //style: Theme.of(context).primaryTextTheme.button,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.black26),
                      shape: MaterialStateProperty.resolveWith<
                          RoundedRectangleBorder>(
                        (state) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (state) => Color(0xff1877f2)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/createKitchen');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith<
                          RoundedRectangleBorder>(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                        (state) => BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    child: Text(
                      'Create Kitchen ?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.headline5.color,
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
