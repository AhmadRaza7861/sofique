// ignore_for_file: non_constant_identifier_names, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/widgets/makeover/make_over_tabs.dart';
import 'package:sofiqe/widgets/makeover/question.dart';
import 'package:sofiqe/widgets/makeover/question_controller.dart';
import 'package:sofiqe/widgets/makeover/question_counter.dart';
import 'package:sofiqe/widgets/makeover/questions_text.dart';

class IngredientsList extends StatefulWidget {
  IngredientsList({Key? key}) : super(key: key);

  @override
  _IngredientsState createState() => _IngredientsState();
}

class _IngredientsState extends State<IngredientsList> {
  MakeOverProvider mopController = Get.find<MakeOverProvider>();
  TextEditingController controller = new TextEditingController();
  TextEditingController newIngredientController = new TextEditingController();
  ScrollController? scrollController;
  FocusNode? focusNode;
  bool enabled = false;
  bool isClicked = false;
  var IngredientsfilteredList = [];
  bool isNewSelection = false;
  List<Map<String, dynamic>> data = [
    {"name": "Amber", "image": "ambereye.png"},
    {"name": "Blue", "image": "blueeye.png"},
    {"name": "Brown", "image": "browneye.png"},
    {"name": "Grey", "image": "greyeye.png"},
    {"name": "Green", "image": "greeneye.png"},
    {"name": "Hazel", "image": "hazel.png"},
    {"name": "Red and voilet", "image": "redeye.png"},
  ];
  @override
  void initState() {
    //  mopController.getIngredeints();
    makeOverProvider.isSearchenable.value = false;
    enabled = false;
    super.initState();
  }


  bool buttonselected = false;
  updateState(bool value) {
    setState(() => buttonselected = value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        //  appBar:
        // AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.0,
        //   leading: GestureDetector(
        //       onTap: () {
        //         mopController.previousQuestion(true);

        //       }, child: Icon(Icons.arrow_back)),
        //   actions: [
        //     Row(
        //       children: [
        //         SizedBox(
        //           width: 1,
        //         ),
        //         Text('Next'),
        //         SizedBox(
        //           width: 5,
        //         ),
        //         InkWell(
        //             onTap: () => Get.to(() => MakeOverHair()),
        //             child: Icon(Icons.arrow_forward)),
        //         SizedBox(
        //           width: 1,
        //         ),
        //       ],
        //     )
        //   ],
        // ),
        body: SingleChildScrollView(
          reverse: enabled,
          // controller: scrollController,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: QuestionController(
                  flowfromIngredients: true,
                ),
              ),
              _TopBar(),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: QuestionCounter(
                    current: mopController.currentQuestion.value + 1,
                    total: mopController.questions.length,
                  ),
                ),
              ),
              QuestionText(questionText: 'Are you allergic to any ingredients'),
              Padding(
                padding: const EdgeInsets.only(right: 35, left: 35, bottom: 10),
                child: Container(
                  height: 45,
                  width: 271,
                  child: TextField(
                    controller: controller,
                    onChanged: (text) {
                      if (text != "") {
                        mopController.onSearchTextChanged(text);
                      } else {
                        mopController.foundAny.value = true;
                        setState(() {});
                      }
                    },
                    onTap: () {
                      setState(() {
                        isClicked = true;
                      });
                    },
                    decoration: new InputDecoration(
                      fillColor: isClicked ? Colors.white : Colors.black,
                      filled: true,
                      contentPadding: EdgeInsets.all(10.0),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      prefixIcon: new Icon(Icons.search,
                          color: isClicked
                              ? Colors.black
                              : AppColors.primaryColor),
                      hintText: mopController.foundAny.value
                          ? "         Search ingredients"
                          : "         Not Found ingredients",
                      hintStyle: new TextStyle(
                        color: isClicked
                            ? Colors.black.withOpacity(0.3)
                            : AppColors.primaryColor,
                        fontSize: 15,
                      ),
                    ),
                    style: new TextStyle(
                      color: Colors.black,
                    ),
                    //  autofocus: true,
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              Obx(() => mopController.foundAny.value
                  ? QuestionArea(true)
                  : newIngredientCreate()),
            ],
          ),
        ),
      ),
    );
  }

  Column newIngredientCreate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: QuestionText(questionText: 'Do You Want To add it?'),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
            height: 50,
            width: 120,
            child: TextButton(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text('Yes',
                    style: TextStyle(
                        color: isNewSelection ? Colors.black : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
              ),
              style: TextButton.styleFrom(
                foregroundColor: isNewSelection ? Colors.white : AppColors.primaryColor,
                backgroundColor: isNewSelection ? Colors.white : Colors.black,
                side: BorderSide(
                    color:
                        isNewSelection ? Colors.white : AppColors.primaryColor,
                    width: 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
              onPressed: () {
                scrollController = ScrollController(
                    //  initialScrollOffset: 0.0,
                    //keepScrollOffset: true,
                    );
                focusNode = FocusNode();
                focusNode?.addListener(() {
                  if (focusNode!.hasFocus) {
                    scrollController!.animateTo(
                        scrollController!.position.extentAfter,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  }
                });
                setState(() {
                  enabled = true;
                  isNewSelection = true;
                });
              },
            ),
          ),
          SizedBox(
            height: 50,
            width: 120,
            child: TextButton(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text('No',
                    style: TextStyle(
                        color: isNewSelection ? Colors.white : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
              ),
              style: TextButton.styleFrom(
                foregroundColor: isNewSelection ? AppColors.primaryColor : Colors.white,
                backgroundColor: isNewSelection ? Colors.black : Colors.white,
                side: BorderSide(
                    color:
                        isNewSelection ? AppColors.primaryColor : Colors.white,
                    width: 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
              onPressed: () {
                // mopController.saveIngredients(mopController.ingredients);
                setState(() {
                  isNewSelection = false;
                  enabled = true;
                });
              },
            ),
          ),
        ]),
        SizedBox(
          height: 15,
        ),
        isNewSelection
            ? QuestionText(questionText: 'Please Add ingredients')
            : SizedBox.shrink(),
        isNewSelection
            ? Padding(
                padding: const EdgeInsets.only(right: 35, left: 35, bottom: 10),
                child: Container(
                  height: 45,
                  width: 271,
                  child: TextField(
                    controller: newIngredientController,
                    onChanged: (text) {
                      if (buttonselected == true) {
                        setState(() {
                          buttonselected = false;
                        });
                      }
                    },
                    onTap: () {
                      setState(() {
                        isClicked = true;
                      });
                    },
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      fillColor: isClicked ? Colors.white : Colors.black,
                      filled: true,
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      // prefixIcon: new Icon(Icons.search,
                      //     color:
                      //         isClicked ? Colors.black : AppColors.primaryColor),
                      // style: new TextStyle(
                      //   color: Colors.black,
                      // ),
                      hintText: "            Add ingredients",
                      hintStyle: new TextStyle(
                        color: Colors.black.withOpacity(0.3),
                        fontSize: 15,
                      ),
                    ),
                    style: new TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            : SizedBox.shrink(),
        isNewSelection
            ? SizedBox(
                height: 50,
                width: 120,
                child: buttonselected == false
                    ? TextButton(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text('Create',
                              style: TextStyle(
                                  color: isNewSelection
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: isNewSelection
                              ? AppColors.primaryColor
                              : Colors.white,
                          backgroundColor:
                              isNewSelection ? Colors.black : Colors.white,
                          side: BorderSide(
                              color: isNewSelection
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              width: 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ),
                        onPressed: buttonselected == false
                            ? () async {
                                updateState(true);

                                if (newIngredientController.text != "") {
                                  if (await mopController.saveNewIngredients(
                                      newIngredientController.text)) {
                                    Get.snackbar("Success",
                                        "New Ingredient Added Successfully",
                                        backgroundColor: AppColors.primaryColor,
                                        isDismissible: true);
                                    newIngredientController.text = "";
                                    updateState(false);
                                  } else {
                                    Get.snackbar(
                                        "Error", "Failed to add new ingredient",
                                        backgroundColor: AppColors.primaryColor,
                                        isDismissible: true);
                                    updateState(false);
                                  }
                                }
                              }
                            : () {})
                    : Center(child:

                SpinKitDoubleBounce(
                  color: Color(0xffF2CA8A),
                  size: 30.0,
                ),
                // CircularProgressIndicator(),
                ))
            : SizedBox.shrink(),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  var listing;

  CustomSearchDelegate(this.listing);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear)),
    ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.backspace));
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var ingredient in listing) {
      if (listing.contains(query.toLowerCase())) {
        matchQuery.add(ingredient);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return Text(matchQuery[index]);
        });

    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var ingredient in listing) {
      if (listing.contains(query.toLowerCase())) {
        matchQuery.add(ingredient);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return Text(matchQuery[index]);
        });

    throw UnimplementedError();
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: size.height * 0.01),
            child: Text(
              'sofiqe',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.03,
                  ),
            ),
          ),
          MakeOverTabs()
        ],
      ),
    );
  }
}