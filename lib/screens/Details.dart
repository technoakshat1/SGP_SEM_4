import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";

import 'package:like_button/like_button.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({Key key}) : super(key: key);

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  int _current = 0;

  List<String> photos = [
    "https://picsum.photos/1920/1080?random=1",
    "https://picsum.photos/1920/1080?random=2",
    "https://picsum.photos/1920/1080?random=3",
    "https://picsum.photos/1920/1080?random=4",
  ];

  List<String> ingredients = ["ING1", "ING2", "ING3", "ING4"];
  List<String> steps = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam molestie blandit arcu vitae suscipit. Ut metus velit, commodo eget laoreet vel, egestas auctor massa. Nulla facilisi. Etiam vulputate malesuada ultricies.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam molestie blandit arcu vitae suscipit. Ut metus velit, commodo eget laoreet vel, egestas auctor massa. Nulla facilisi. Etiam vulputate malesuada ultricies."
  ];

  CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
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
                        NetworkImage("https://picsum.photos/200/300"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "KITCHEN_ID",
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
              "Title",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor #incididunt ero labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco poriti laboris nisi ut aliquip ex ea commodo consequat.",
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
                    "2 hours",
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
                    "250",
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
