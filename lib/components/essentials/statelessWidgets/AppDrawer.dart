import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Drawer(
      child: new ListView(
          children: [
            new UserAccountsDrawerHeader(accountName: Text('Rushi Jobanputra'), accountEmail: Text('rushijobanputra1203@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: Icon(Icons.person, color: Colors.white,) ,
                ),
              ),
              decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
            ),

            InkWell(
                onTap: (){},
                child: new  ListTile(
                  title: Text('Favourites'),
                  leading: Icon(Icons.favorite),)
            ),

            InkWell(
                onTap: (){},
                child: new  ListTile(
                  title: Text('Breakfast'),
                  leading: Icon(Icons.free_breakfast_outlined),)
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(title: Text('Brunch'),
                leading: Icon(Icons.brunch_dining),),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(title: Text('Lunch'),
                leading: Icon(Icons.fastfood_outlined),),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(title: Text('High Tea'),
                leading: Icon(Icons.restaurant_menu_sharp),),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(title: Text('Dinner'),
                leading: Icon(Icons.dinner_dining),),
            ),
            InkWell(
              onTap: (){},
              child: new ListTile(title: Text('Desert'),
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
                
              },
              child: new ListTile(title: Text('Logout'),
                leading: Icon(Icons.exit_to_app),),
            ),
            

          ],
        ),
    );
  }
}