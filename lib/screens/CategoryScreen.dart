import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../components/essentials/statefulWidgets/card.dart';
import '../components/appBars/LogoAppBar.dart';
import '../components/essentials/statelessWidgets/AppDrawer.dart';

import '../backend/Models/post/post.dart';
import '../backend/httpController/PostController.dart';
import '../backend/httpController/AuthController.dart';
import '../backend/Models/authentication/DisplayUser.dart';

class CateogryScreen extends StatefulWidget {
  CateogryScreen({Key key,this.category}) : super(key: key);

  final Categories category;

  @override
  _CateogryScreenState createState() => _CateogryScreenState();
}

class _CateogryScreenState extends State<CateogryScreen> {
 List<Post> posts;
 final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PostController controller = PostController();
   AuthController authController = AuthController();
  DisplayUser displayUser=DisplayUser();

  @override
  void initState() {
    super.initState();
    loadPosts();
    loadUserDetails();
  }

  
  void loadUserDetails() async {
    DisplayUser user = await authController.getCurrentUser();
    setState(() {
      displayUser=user;
    });
  }


  void loadPosts() async {
    final posts = await controller.getPostsByCategories(widget.category);
    setState(() {
      this.posts = posts;
    });
  }

  Future<void> refreshPosts() async {
    final posts = await controller.getPostsByCategories(widget.category);
    setState(() {
      this.posts = posts;
    });
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {

    var childToRender;

    if(posts==null){
      childToRender= Column(
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
    }else{
      childToRender=ListView.builder(
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
      appBar: LogoAppBar(user: displayUser,scaffoldState: _scaffoldKey,),
      drawer: AppDrawer(user: displayUser,),
      body: RefreshIndicator(
        onRefresh: refreshPosts,
        child:childToRender,
      ),
    );
  }
}