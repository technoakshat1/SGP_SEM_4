import 'package:flutter/material.dart';

//components
import '../components/AppDrawer.dart';

import '../backend/httpController/AuthController.dart';

import '../backend/bloc/FacebookCubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  final AuthController obj=new AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Kitchen cloud'),
        actions: [
          new IconButton(icon: Icon(Icons.search , color: Colors.white,), onPressed: (){}),
          new IconButton(icon: Icon(Icons.shopping_cart , color: Colors.white,), onPressed: (){})
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: [
            new UserAccountsDrawerHeader(accountName: Text('Rushi Jobanputra'), accountEmail: Text('rushijobanputra1203@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: Icon(Icons.person, color: Colors.white,) ,
                ),
              ),
              decoration: new BoxDecoration(color: Colors.blue),
            ),

            InkWell(
                onTap: (){},
                child: new  ListTile(
                  title: Text('FAVORITES'),
                  leading: Icon(Icons.favorite),)
            ),

            InkWell(
                onTap: (){},
                child: new  ListTile(
                  title: Text('BREAKFAST'),
                  leading: Icon(Icons.free_breakfast_outlined),)
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(title: Text('BRUNCH'),
                leading: Icon(Icons.brunch_dining),),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(title: Text('LUNCH'),
                leading: Icon(Icons.fastfood_outlined),),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(title: Text('HIGH TEA'),
                leading: Icon(Icons.restaurant_menu_sharp),),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(title: Text('DINNER'),
                leading: Icon(Icons.dinner_dining),),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(title: Text('DESERT'),
                leading: Icon(Icons.icecream),),
            ),
            Divider(),

            InkWell(
              onTap: (){},
              child: new ListTile(title: Text('Settings'),
                leading: Icon(Icons.settings),),
            ),

             InkWell(
              onTap: (){
                 FacebookCubit cubit=FacebookCubit();
                 cubit.logOut();
              },
              child: new ListTile(title: Text('LogOut'),
                leading: Icon(Icons.settings),),
            ),
            

          ],
        ),
      ),

    ); //build drawer in app drawer file
  }
}