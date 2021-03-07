import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:password_strength/password_strength.dart';

//components
import '../components/TextOnlyFieldCircular.dart';
import '../components/PasswordOnlyFieldCircular.dart';
import '../components/AccentButtonCircular.dart';
import '../components/DefaultPageTransition.dart';
import '../screens/SignUpLoadingScreen.dart';

//blocs
import '../backend/bloc/SignUpCubit.dart';

//Models
import '../backend/Models/SignUpUser.dart';

// TODO UI:add warning text for :
//         1.email field is empty or invalid.
//         2.username field is not available i.e. already taken or invalid.
//         3.first name last name empty or invalid.
//         4.password strength check and warning.
//         5.add bacl button to appbar.
//       Function:
//         1.connect and get user inputs from diffrent inputs using bloc.
//         2.make create button working.
//         3.make back button working i.e it takes back to sign in screen.

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ScrollController controller = ScrollController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final SignUpCubit cubitA = SignUpCubit();

  static final _formKey = new GlobalKey<FormState>();

  /// just  define _formkey with static final

  Key _k1 = new GlobalKey();

  bool isUsernameValid = false;
  bool isFirstNameValid = true;
  bool isLastNameValid = true;
  bool isEmailValid = true;
  double passwordStrength = 0.2;
  bool passwordMatch = false;

  void validateUsername(String username) {
    if (username != null && username.length != 0) {
      cubitA.usernameAvailable(username);
    } else {
      setState(() {
        isUsernameValid = false;
      });
    }
  }

  void validateFirstName(String firstName) {
    if (firstName != null && firstName.length != 0) {
      setState(() {
        isFirstNameValid = true;
      });
    } else {
      setState(() {
        isFirstNameValid = false;
      });
    }
  }

  void validateLastName(String lastName) {
    if (lastName != null && lastName.length != 0) {
      setState(() {
        isLastNameValid = true;
      });
    } else {
      setState(() {
        isLastNameValid = false;
      });
    }
  }

  void validateEmail(String email) {
    setState(() {
      isEmailValid = EmailValidator.validate(email, true);
    });
  }

  void validatePassword(String password) {
    setState(() {
      passwordStrength = estimatePasswordStrength(password);
    });
  }

  void validateConfirmPassword(String confirmPassword) {
    if (passwordStrength > 0.3) {
      if (passwordController.text == confirmPassword) {
        setState(() {
          passwordMatch = true;
        });
      } else {
        setState(() {
          passwordMatch = false;
        });
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String imageAssetUri = "assets/images/logo_text_dark_theme.png";
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        imageAssetUri = "assets/images/logo_text_light_theme.png";
        break;
      case Brightness.dark:
        imageAssetUri = "assets/images/logo_text_dark_theme.png";
        break;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 120,
              child: Image.asset(imageAssetUri, fit: BoxFit.cover),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Scrollbar(
        controller: controller,
        isAlwaysShown: true,
        child: BlocProvider.value(
          value: cubitA,
          child: SingleChildScrollView(
            controller: controller,
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Form(
                    key: _formKey,
                    child: BlocConsumer<SignUpCubit, dynamic>(
                      listener: (ctx, state) {
                        if (state is UsernameAvailability) {
                          if (state == UsernameAvailability.Available) {
                            setState(() {
                              isUsernameValid = true;
                            });
                          } else if (state == UsernameAvailability.Loading ||
                              state == UsernameAvailability.UnAvailable) {
                            setState(() {
                              isUsernameValid = false;
                            });
                          }
                        }
                      },
                      builder: (ctx, state) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Create Kitchen',
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 0),
                            padding: EdgeInsets.all(10),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                if (isUsernameValid)
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                  ),
                                if (!isUsernameValid)
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  ),
                                if (state is UsernameAvailability &&
                                    state == UsernameAvailability.Loading)
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      value: null,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).accentColor,
                                      ),
                                      strokeWidth: 3.0,
                                    ),
                                  ),
                                Container(
                                  child: TextOnlyFieldCircular(
                                    key: _k1,
                                    labelText: '*Username',
                                    labelFocusColor: !isUsernameValid
                                        ? Colors.red
                                        : Color(0xffaf0069),
                                    labelUnfocusedColor: !isUsernameValid
                                        ? Colors.red
                                        : Colors.grey,
                                    textController: usernameController,
                                    onChange: validateUsername,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextOnlyFieldCircular(
                              labelText: '*First Name',
                              labelFocusColor: !isFirstNameValid
                                  ? Colors.red
                                  : Color(0xffaf0069),
                              labelUnfocusedColor:
                                  !isFirstNameValid ? Colors.red : Colors.grey,
                              textController: firstNameController,
                              onChange: validateFirstName,
                            ),
                          ),
                          if (!isFirstNameValid)
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                'First Name is empty!',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            padding: EdgeInsets.all(10),
                            child: TextOnlyFieldCircular(
                              labelText: '*Last Name',
                              labelFocusColor: !isLastNameValid
                                  ? Colors.red
                                  : Color(0xffaf0069),
                              labelUnfocusedColor:
                                  !isLastNameValid ? Colors.red : Colors.grey,
                              textController: lastNameController,
                              onChange: validateLastName,
                            ),
                          ),
                          if (!isLastNameValid)
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Text(
                                'Last Name is empty!',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextOnlyFieldCircular(
                              labelText: '*Email',
                              labelFocusColor: !isEmailValid
                                  ? Colors.red
                                  : Color(0xffaf0069),
                              labelUnfocusedColor:
                                  !isEmailValid ? Colors.red : Colors.grey,
                              textController: emailController,
                              onChange: validateEmail,
                            ),
                          ),
                          if (!isEmailValid)
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                'Email is in-valid or empty!',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            padding: EdgeInsets.all(10),
                            child: PasswordOnlyFieldCircular(
                              labelText: '*Password',
                              labelFocusColor: passwordStrength < 0.3
                                  ? Colors.red
                                  : Color(0xffaf0069),
                              labelUnfocusedColor: passwordStrength < 0.3
                                  ? Colors.red
                                  : Colors.grey,
                              textController: passwordController,
                              onChange: validatePassword,
                            ),
                          ),
                          if (passwordStrength < 0.3)
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                'Password is weak !',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.all(10),
                            child: PasswordOnlyFieldCircular(
                              labelText: '*Confirm Password',
                              labelFocusColor: !passwordMatch
                                  ? Colors.red
                                  : Color(0xffaf0069),
                              labelUnfocusedColor:
                                  !passwordMatch ? Colors.red : Colors.grey,
                              textController: confirmPasswordController,
                              onChange: validateConfirmPassword,
                            ),
                          ),
                          if (!passwordMatch)
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Text(
                                'Password doesn\'t match!',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '*By creating an account you agree to our Terms of Service and Privacy Policy*',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: 300,
                            height: 40,
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 0),
                            child: AccentButtonCircular(
                              displayText: 'Create Kitchen',
                              onPress: () {
                                String username = usernameController.text;
                                String firstName = firstNameController.text;
                                String lastName = lastNameController.text;
                                String email = emailController.text;
                                String password = passwordController.text;

                                if (username?.length != 0 &&
                                    isUsernameValid &&
                                    passwordStrength > 0.3 &&
                                    passwordMatch &&
                                    firstName?.length != 0 &&
                                    isFirstNameValid &&
                                    lastName?.length != 0 &&
                                    isLastNameValid && email?.length!=0) {
                                  SignUpUser user = SignUpUser(
                                      username: username,
                                      password: password,
                                      firstName: firstName,
                                      lastName: lastName,
                                      email: email);
                                  cubitA.signUp(user);
                                  DefaultPageTransition transition =
                                      DefaultPageTransition(
                                          SignUpLoadingScreen(cubit: cubitA));
                                  Navigator.of(ctx)
                                      .push(transition.createRoute());
                                } else if (firstName?.length == 0) {
                                  setState(() {
                                    isFirstNameValid = false;
                                  });
                                } else if (lastName?.length == 0) {
                                  setState(() {
                                    isLastNameValid = false;
                                  });
                                } else if (email?.length == 0) {
                                  setState(() {
                                    isEmailValid = false;
                                  });
                                } else if (passwordStrength < 0.3) {
                                  setState(() {});
                                } else if (passwordMatch) {
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
