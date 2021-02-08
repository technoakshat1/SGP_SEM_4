import 'package:flutter/material.dart';

//components
import '../components/TextOnlyFieldCircular.dart';
import '../components/PasswordOnlyFieldCircular.dart';
import '../components/AccentButtonCircular.dart';

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

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key key}) : super(key: key);

  final ScrollController controller = ScrollController();

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
              height:120,
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
        child: SingleChildScrollView(
          controller: controller,
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Create Kitchen',
                        style: Theme.of(context).primaryTextTheme.headline5,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                      padding: EdgeInsets.all(10),
                      child: TextOnlyFieldCircular(
                        labelText: 'Username',
                        labelFocusColor: Color(0xffaf0069),
                        labelUnfocusedColor: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextOnlyFieldCircular(
                        labelText: 'First Name',
                        labelFocusColor: Color(0xffaf0069),
                        labelUnfocusedColor: Colors.grey,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                      padding: EdgeInsets.all(10),
                      child: TextOnlyFieldCircular(
                        labelText: 'Last Name',
                        labelFocusColor: Color(0xffaf0069),
                        labelUnfocusedColor: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextOnlyFieldCircular(
                        labelText: 'Email',
                        labelFocusColor: Color(0xffaf0069),
                        labelUnfocusedColor: Colors.grey,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                      padding: EdgeInsets.all(10),
                      child: PasswordOnlyFieldCircular(
                        labelText: 'Password',
                        labelFocusColor: Color(0xffaf0069),
                        labelUnfocusedColor: Colors.grey,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.all(10),
                      child: PasswordOnlyFieldCircular(
                        labelText: 'Confirm Password',
                        labelFocusColor: Color(0xffaf0069),
                        labelUnfocusedColor: Colors.grey,
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
                      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                      child:
                          AccentButtonCircular(displayText: 'Create Kitchen'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
