import 'package:flutter/material.dart';

//components
import '../components/AppDrawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext ctx) {
            return IconButton(
              icon: const Icon(Icons.account_circle_rounded),//placeholder to be replaced by image widget 
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
            );
          },
        ),
      ),
      body: Text('hello world'),//build body
      drawer: AppDrawer(),//build drawer in app drawer file
    );
  }
}
