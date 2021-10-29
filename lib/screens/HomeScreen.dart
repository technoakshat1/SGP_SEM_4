import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../backend/Models/post/post.dart';

import '../backend/httpController/PostController.dart';
import '../backend/httpController/AuthController.dart';
import '../backend/Models/authentication/DisplayUser.dart';

import '../screens/CreateRecipeScreen.dart';

//components

import "../components/essentials/statelessWidgets/AppDrawer.dart";
import "../components/appBars/LogoAppBar.dart";
import '../components/essentials/statefulWidgets/card.dart';
import '../components/essentials/statelessWidgets/FABCreateRecipe.dart';
import '../components/animatedRoutes/DefaultPageTransition.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> posts;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PostController controller = PostController();
  AuthController authController = AuthController();
  DisplayUser displayUser = DisplayUser();

  @override
  void initState() {
    super.initState();
    loadPosts();
    loadUserDetails();
  }

  void loadPosts() async {
    final posts = await controller.getPosts();
    setState(() {
      this.posts = posts;
    });
  }

  void loadUserDetails() async {
    DisplayUser user = await authController.getCurrentUser();
    setState(() {
      displayUser = user;
    });
  }

  Future<void> refreshPosts() async {
    final posts = await controller.getPosts();
    setState(() {
      this.posts = posts;
    });
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    var childToRender;

    if (posts == null) {
      childToRender = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(0),
            child: Text(
              'Namaste!',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Lottie.asset('assets/animation/namaste_kitchen.json'),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Welcome to kitchen Cloud!',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      );
    } else {
      childToRender = ListView.builder(
        itemBuilder: (ctx, index) => PostCard(
          username: posts[index].username,
          title: posts[index].title,
          postId: posts[index].id,
          postDisplayPhotoUrl: posts[index].images[0],
          caption: posts[index].caption,
        ),
        itemCount: posts.length,
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: LogoAppBar(
        user: displayUser,
        scaffoldState: _scaffoldKey,
      ),
      drawer: AppDrawer(
        user: displayUser,
      ),
      body: RefreshIndicator(
        onRefresh: refreshPosts,
        child: childToRender,
      ),
      floatingActionButton: FABCreateRecipe(
        onPress: () {
          DefaultPageTransition transition =
              DefaultPageTransition(CreateRecipeScreen());
          Navigator.of(context).push(transition.createRoute());
        },
      ),
    );
  }
}
