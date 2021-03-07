import 'package:flutter/material.dart';

//components
import '../components/AppDrawer.dart';

import '../backend/httpController/AuthController.dart';

import '../backend/Models/SignUpUser.dart';
import '../backend/Models/loginUser.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  
  final AuthController obj=new AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext ctx) {
            return IconButton(
              icon: const Icon(Icons
                  .account_circle_rounded), //placeholder to be replaced by image widget
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
            );
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Press Me"),
            onPressed: () {
               //LoginUser user=new LoginUser(username:"test10",password:"test10");
              //  SignUpUser user= new SignUpUser(
              //   username:"test12",
              //   password:"test10",
              //   email:"abc@test.com",
              //   firstName:"test",
              //   lastName:"number10"
              //  );
              //obj.signUp(user);
              //obj.login(user);
              //obj.usernameAvailable('test10');
            }
          ),
           RaisedButton(
            child: Text("Logout"),
            onPressed: () {
               obj.logout();
            }
          ),
        ],
      ), //build body
      drawer: AppDrawer(), //build drawer in app drawer file
    );
  }
}
