import 'package:flutter/material.dart';

//components

import '../backend/httpController/AuthController.dart';

import "../components/essentials/statelessWidgets/AppDrawer.dart";
import "../components/appBars/LogoAppBar.dart";

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  final AuthController obj=new AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(),
      drawer: AppDrawer(),
      body:ListView.builder(
        itemBuilder: (ctx,count)=>Text("Hello"),//TODO:Build Item Card
        itemCount: 1,
      ),
    ); 
  }
}