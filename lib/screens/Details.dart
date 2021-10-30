import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";

import 'package:like_button/like_button.dart';
import 'package:recipe_app/backend/Models/authentication/DisplayUser.dart';
import 'package:recipe_app/backend/httpController/AuthController.dart';
import 'package:recipe_app/backend/httpController/PostController.dart';

class RecipeDetailScreen extends StatefulWidget {
  RecipeDetailScreen({Key key,this.id,}) : super(key: key);
  final String id;
  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  int _current = 0;
  var data;
  List<String> photos = [];
  List<String> ingredients = [];
  List<String> steps = [];
  AuthController authController = AuthController();
  DisplayUser displayUser=DisplayUser();
  @override
  void initState(){
    super.initState();
    setState(() {
      initData();
    });


  }
  void initData()async{
    PostController p1=PostController();
    data=await p1.getPostById(widget.id);
    for(int i=0;i<data["media"]["images"].length;i++){
      photos.add(data["media"]["images"][i].toString());
    }
    for(int i=0;i<data["CookingInfo"]["ingredients"].length;i++){
      ingredients.add(data["CookingInfo"]["ingredients"][i].toString());
    }
    for(int i=0;i<data["Method"]["steps"].length;i++){
      steps.add(data["Method"]["steps"][i].toString());

    }
    DisplayUser user = await authController.getCurrentUser();
    print(displayUser.photoUrl);
    setState(() {
      displayUser = user;
    });

  }




  CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () {

// Here you can write your code

      setState(() {
        // Here you can write your code for open new view
      });

    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(displayUser.photoUrl),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    data["userId"].toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Theme.of(context).accentColor),
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (states) {
                          if (states.any(
                              (element) => element == MaterialState.pressed)) {
                            return Colors.black;
                          }

                          return Theme.of(context).accentColor;
                        },
                      ),
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star_border),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text("Favourites"),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: false,
                  height: 1080,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              carouselController: _controller,
              items: photos
                  .map(
                    (e) => Container(
                      child: Image.network(
                        e,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: photos.asMap().entries.map((entry) {
              return Container(
                width: 5,
                height: 5,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(
                    _current == entry.key ? 0.9 : 0.4,
                  ),
                ),
              );
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              data["title"],
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              data["caption"],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text(
              "Cooking Info",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 50,
                  color: Theme.of(context).accentColor,
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    data["CookingInfo"]["time"],
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  "₹",
                  style: TextStyle(
                    fontSize: 50,
                    color: Theme.of(context).accentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: Text(
                    data["CookingInfo"]["cost"],
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.people,
                  size: 50,
                  color: Theme.of(context).accentColor,
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "4",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: Text(
              "Ingredients",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          ...ingredients.map(
            (e) => Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Text(
                e,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: Text(
              "Method",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          ...steps
              .asMap()
              .entries
              .map(
                (e) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Step-${e.key + 1}",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(e.value),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
          Container(
            margin: EdgeInsets.all(30),
            child: Row(
              children: [
                Container(
                  child: LikeButton(
                    size: 40,
                    likeCount: 20,
                    isLiked: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: LikeButton(
                    size: 40,
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
                    size: 40,
                    likeBuilder: (_) => Icon(Icons.share),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Container(
//                 width: 12.0,
//                 height: 12.0,
//                 margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: (Theme.of(context).brightness == Brightness.dark
//                             ? Colors.white
//                             : Colors.black)
//                         .withOpacity(_current == entry.key ? 0.9 : 0.4)),
//               ),
