import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import '../backend/Models/authentication/DisplayUser.dart';
import '../backend/httpController/AuthController.dart';
import '../components/appBars/LogoAppBar.dart';
import '../components/essentials/statelessWidgets/AppDrawer.dart';
import '../components/authentication/statefulWidgets/TextOnlyFieldCircular.dart';

import '../components/createRecipe/statefull/CategoriesList.dart';
import '../components/createRecipe/statefull/FilterList.dart';
import '../components/createRecipe/stateless/PhotoVideoInput.dart';
import '../components/createRecipe/statefull/MultiTextField.dart';
import '../components/createRecipe/statefull/MultiSteps.dart';

enum Comments { ON, OFF }

class CreateRecipeScreen extends StatefulWidget {
  CreateRecipeScreen({Key key}) : super(key: key);

  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  AuthController authController = AuthController();
  DisplayUser displayUser = DisplayUser();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController controller = TextEditingController();
  Comments status = Comments.OFF;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  void loadUserDetails() async {
    DisplayUser user = await authController.getCurrentUser();
    setState(() {
      displayUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: LogoAppBar(
        user: displayUser,
        scaffoldState: _scaffoldKey,
      ),
      drawer: AppDrawer(
        user: displayUser,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "Create Recipe",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            PhotoVideoInput(),
            Container(
              padding: EdgeInsets.all(10),
              child: TextOnlyFieldCircular(
                labelText: "Title",
                labelFocusColor: Color(0xffaf0069),
                labelUnfocusedColor: Theme.of(context).accentColor,
                onChange: (_) {},
                textController: controller,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Caption",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              child: TextField(
                maxLines: 7,
                maxLength: 255,
                decoration: InputDecoration(border: InputBorder.none),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            CategoriesList(),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Filters",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            FilterList(),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Cooking Info",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    child: Icon(Icons.timer),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Time",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextOnlyFieldCircular(
                labelText: "Time",
                labelFocusColor: Color(0xffaf0069),
                labelUnfocusedColor: Theme.of(context).accentColor,
                onChange: (_) {},
                textController: controller,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "\u{20B9} Cost of Ingredients",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextOnlyFieldCircular(
                labelText: "Cost",
                labelFocusColor: Color(0xffaf0069),
                labelUnfocusedColor: Theme.of(context).accentColor,
                onChange: (_) {},
                textController: controller,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    child: Icon(Icons.people),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Persons",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: FlutterSlider(
                values: [5],
                max: 10,
                min: 1,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  return 8;
                },
                trackBar: FlutterSliderTrackBar(
                  activeTrackBar: BoxDecoration(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    child: Icon(Icons.shopping_basket),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Ingredients",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: MultiTextField(),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Method Steps",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            MultiSteps(),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Comments",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            RadioListTile(
              title: Text("OFF"),
              value: Comments.OFF,
              groupValue: status,
              onChanged: (Comments value) {
                setState(() {
                  status = value;
                });
              },
            ),
            RadioListTile(
              title: Text("ON"),
              value: Comments.ON,
              groupValue: status,
              onChanged: (Comments value) {
                setState(() {
                  status = value;
                });
              },
            ),
            Container(
              width: 200,
              margin: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: (){},
                icon: Icon(Icons.save),
                label: Text("Save"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
