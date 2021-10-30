import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../../backend/httpController/AuthController.dart';
import '../../../backend/httpController/LikeController.dart';
import '../../../backend/Models/authentication/DisplayUser.dart';

import '../../animatedRoutes/DefaultPageTransition.dart';
import '../../../screens/Details.dart';

class PostCard extends StatefulWidget {
  PostCard({
    Key key,
    this.title,
    this.caption,
    this.postDisplayPhotoUrl,
    this.username,
    this.postId,
  }) : super(key: key);
  final String username;
  final String title;
  final String caption;
  final String postDisplayPhotoUrl;
  final String postId;

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  LikeController controller = LikeController();
  AuthController authController = AuthController();
  int likesCount = 0;
  bool isLiked = false;
  DisplayUser user;

  @override
  void initState() {
    super.initState();
    initLikes();
    initUser();
  }

  void initLikes() async {
    this.likesCount = await controller.getLikes(widget.postId);
    isLiked = await controller.hasUserLiked(widget.postId);
    setState(() {});
  }

  void initUser() async {
    user = await authController.getUserDetails(widget.username);
    setState(() {});
  }

  Future<bool> onLikePress(bool isLiked) async {
    if (!isLiked) {
      bool liked = await controller.like(widget.postId);
      if (liked) {
        setState(() {
          this.likesCount++;
          this.isLiked = true;
        });
      }
    } else {
      bool unliked = await controller.unlike(widget.postId);
      if (unliked) {
        setState(() {
          likesCount--;
          this.isLiked = false;
        });
      }
    }
    return this.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            DefaultPageTransition transition =
                DefaultPageTransition(RecipeDetailScreen(id:widget.postId));
            Navigator.of(context).push(transition.createRoute());
          },
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(3),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: user == null
                                  ? AssetImage(
                                      "assets/images/logo_dark_theme.png")
                                  : NetworkImage(user.photoUrl),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(9),
                          child: Text(widget.username,
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(widget.title, style: TextStyle(fontSize: 20)),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 200,
                    width: 250,
                    child: Image.network(
                      widget.postDisplayPhotoUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(widget.caption),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          child: LikeButton(
                            size: 25,
                            likeCount: likesCount,
                            onTap: onLikePress,
                            isLiked: isLiked,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: LikeButton(
                            size: 25,
                            likeCount: 300,
                            likeBuilder: (isLike) => Icon(
                              Icons.message,
                              color: isLike ? Colors.greenAccent : Colors.grey,
                            ),
                            circleColor: CircleColor(
                              end: Theme.of(context).primaryColorDark,
                              start: Theme.of(context).primaryColorLight,
                            ),

                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: LikeButton(
                            size: 25,
                            likeBuilder: (_) => Icon(Icons.share),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
