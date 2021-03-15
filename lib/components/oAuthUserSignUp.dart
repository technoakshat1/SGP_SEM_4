import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//components
import './TextOnlyFieldCircular.dart';
import './AccentButtonCircular.dart';
import './DefaultPageTransition.dart';

//screens
import '../screens/SignUpLoadingScreen.dart';

//blocs
import '../backend/bloc/GoogleCubit.dart';
import '../backend/bloc/SignUpCubit.dart';

class OAuthSignUpDialog extends StatefulWidget {
  OAuthSignUpDialog({Key key, this.cubitA}) : super(key: key);

  final GoogleCubit cubitA;

  @override
  _OAuthSignUpDialogState createState() => _OAuthSignUpDialogState();
}

class _OAuthSignUpDialogState extends State<OAuthSignUpDialog> {
  final TextEditingController usernameController = TextEditingController();
  final SignUpCubit cubitB = SignUpCubit();
  final GlobalKey _k1 = GlobalKey();
  bool loading = false;
  bool isUsernameAvailable = false;

  void validateUsername(String username) {
    if (username != null && username.length != 0) {
      cubitB.usernameAvailable(username);
      setState(() {
        isUsernameAvailable = true;
      });
    } else {
      setState(() {
        isUsernameAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // BlocListener<GoogleCubit, GoogleLoginStatus>(
        //     cubit: widget.cubitA,
        //     listener: (ctx, state) {
        //       //do something
        //     }),
        BlocListener<SignUpCubit, dynamic>(
          cubit: cubitB,
          listener: (ctx, state) {
            if (state is UsernameAvailability) {
              if (state == UsernameAvailability.Loading) {
                setState(() {
                  loading = true;
                  isUsernameAvailable = false;
                });
              } else if (state == UsernameAvailability.Available) {
                setState(() {
                  loading = false;
                  isUsernameAvailable = true;
                });
              } else if (state == UsernameAvailability.UnAvailable) {
                setState(() {
                  loading = false;
                  isUsernameAvailable = false;
                });
              }
            }
          },
        ),
      ],
      child: SimpleDialog(
        title: Text('Welcome to Kitchen Cloud!'),
        insetPadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(5),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Looks like you are new to Kitchen Cloud!\nPlease enter an appropriate username to continue!',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
            padding: EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                if (isUsernameAvailable)
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ),
                if (!isUsernameAvailable)
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                if (loading)
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      value: null,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).accentColor,
                      ),
                      strokeWidth: 3.0,
                    ),
                  ),
                Container(
                  child: TextOnlyFieldCircular(
                    key: _k1,
                    labelText: '*Username',
                    labelFocusColor:
                        !isUsernameAvailable ? Colors.red : Color(0xffaf0069),
                    labelUnfocusedColor:
                        !isUsernameAvailable ? Colors.red : Colors.grey,
                    textController: usernameController,
                    onChange: validateUsername,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 300,
            height: 40,
            margin: EdgeInsets.fromLTRB(20, 10, 10, 20),
            child: Stack(
              children: [
                Container(
                  width: 300,
                  height: 40,
                  child: AccentButtonCircular(
                    displayText: 'SignUp',
                    onPress: () {
                      String username=usernameController.text;
                      if (isUsernameAvailable && username.isNotEmpty) {
                        widget.cubitA.signUp(username);
                        DefaultPageTransition transition =
                            DefaultPageTransition(SignUpLoadingScreen(cubit:widget.cubitA));
                        Navigator.of(context)
                            .pushReplacement(transition.createRoute());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
