import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//components
import '../components/TextOnlyFieldCircular.dart';
import '../components/PasswordOnlyFieldCircular.dart';
import '../components/AccentButtonCircular.dart';

// TODO UI:add warning text for :
//         1.username field is not available i.e. invalid.
//         2.password empty or invalid
//       Function:
//         1.connect and get user inputs from diffrent inputs using bloc.
//         2.make login button working.
//         3.make sign in with google working.
//         4.make continue with facebook working.

class SignInScreen extends StatelessWidget {
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
        child: Column(
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
                labelText: 'Username',
                labelFocusColor: Color(0xffaf0069),
                labelUnfocusedColor: Colors.grey,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              padding: EdgeInsets.all(10),
              child: PasswordOnlyFieldCircular(
                labelText: 'Password',
                labelFocusColor: Color(0xffaf0069),
                labelUnfocusedColor: Colors.grey,
              ),
            ),
            Container(
              width: 300,
              height: 40,
              child: AccentButtonCircular(
                displayText: 'Login',
              ),
            ),
            Container(
              width: 300,
              height: 40,
              margin: EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: () {},
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
                onPressed: () {},
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
                 onPressed: (){
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
    );
  }
}
