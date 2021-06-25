import 'package:flutter/material.dart';
import '../../../backend/bloc/LoginCubit.dart';
import '../../../backend/bloc/FacebookCubit.dart';
import '../../../backend/bloc/GoogleCubit.dart';

import '../../../backend/Models/post/post.dart';

import '../../../backend/Models/authentication/DisplayUser.dart';

import '../../animatedRoutes/DefaultPageTransition.dart';
import '../../../screens/CategoryScreen.dart';
import '../../../screens/HomeScreen.dart';
import '../../../screens/Settings.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({this.user});

  DisplayUser user;

  DefaultPageTransition transition;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: [
          new UserAccountsDrawerHeader(
            accountName: Text(user == null ? 'loading...' : user.username),
            accountEmail: Text(user == null ? 'loading...' : user.displayName),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.black12,
                foregroundImage: user == null 
                    ? AssetImage("assets/images/logo_dark_theme.png")
                    : NetworkImage(user.photoUrl),
              ),
            ),
            decoration: new BoxDecoration(
              image: DecorationImage(
                colorFilter:  ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.6), BlendMode.darken),
                fit: BoxFit.cover,
                image: user == null 
                    ? AssetImage("assets/images/logo_dark_theme.png")
                    : NetworkImage(user.photoUrl),
              ),
            ),
          ),

          InkWell(
              onTap: () {
                transition = DefaultPageTransition(HomeScreen());
                Navigator.of(context).pushReplacement(transition.createRoute());
              },
              child: new ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home),
              )),

          InkWell(
              onTap: () {
                transition = DefaultPageTransition(
                    CateogryScreen(category: Categories.BREAKFAST));
                Navigator.of(context).pushReplacement(transition.createRoute());
              },
              child: new ListTile(
                title: Text('Breakfast'),
                leading: Icon(Icons.free_breakfast_outlined),
              )),
          InkWell(
            onTap: () {
              transition = DefaultPageTransition(
                  CateogryScreen(category: Categories.BRUNCH));
              Navigator.of(context).pushReplacement(transition.createRoute());
            },
            child: new ListTile(
              title: Text('Brunch'),
              leading: Icon(Icons.brunch_dining),
            ),
          ),
          InkWell(
            onTap: () {
              transition = DefaultPageTransition(
                  CateogryScreen(category: Categories.LUNCH));
              Navigator.of(context).pushReplacement(transition.createRoute());
            },
            child: new ListTile(
              title: Text('Lunch'),
              leading: Icon(Icons.fastfood_outlined),
            ),
          ),
          InkWell(
            onTap: () {
              transition = DefaultPageTransition(
                  CateogryScreen(category: Categories.HIGH_TEA));
              Navigator.of(context).pushReplacement(transition.createRoute());
            },
            child: new ListTile(
              title: Text('High Tea'),
              leading: Icon(Icons.restaurant_menu_sharp),
            ),
          ),
          InkWell(
            onTap: () {
              transition = DefaultPageTransition(
                  CateogryScreen(category: Categories.DINNER));
              Navigator.of(context).pushReplacement(transition.createRoute());
            },
            child: new ListTile(
              title: Text('Dinner'),
              leading: Icon(Icons.dinner_dining),
            ),
          ),
          // InkWell(
          //   onTap: (){

          //   },
          //   child: new ListTile(title: Text('Desert'),
          //     leading: Icon(Icons.icecream),),
          // ),
          Divider(),

          InkWell(
            onTap: () {
              DefaultPageTransition transition=DefaultPageTransition(Settings());
              Navigator.of(context).pushReplacement(transition.createRoute());
            },
            child: new ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
          ),

          InkWell(
            onTap: () {
              LoginCubit cubit = LoginCubit();
              GoogleCubit gcubit = GoogleCubit();
              FacebookCubit fcubit = FacebookCubit();
              cubit.logout();
              gcubit.logout();
              fcubit.logOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: new ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
    );
  }
}
