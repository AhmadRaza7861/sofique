import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/controller/questionController.dart';
import 'package:sofiqe/model/ingredients_model.dart';
// Provider
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
// Utils
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/widgets/capsule_button.dart';
import 'package:sofiqe/widgets/makeover/question_counter.dart';
import 'package:sofiqe/widgets/makeover/questions_text.dart';

class QuestionArea extends StatefulWidget {
  QuestionArea(this.flowFromingrediets);

  final bool flowFromingrediets;

  @override
  State<QuestionArea> createState() => _QuestionAreaState();
}

class _QuestionAreaState extends State<QuestionArea> {
  final QuestionsController ques = Get.find();

  void onInit() {
    makeOverProvider.getIngredeints();
  }

  @override
  Widget build(BuildContext context) {
    //  makeOverProvider.getIngredeints();

    print(makeOverProvider.question.runtimeType);
    return Container(
        padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: widget.flowFromingrediets
            ? Obx(() {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: makeOverProvider.isSearchenable.value
                        ? makeOverProvider.ingredientsfilteredlist.length
                        : makeOverProvider.ingredients.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0),
                    itemBuilder: (BuildContext context, int index) {
                      return
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: _ChoiceButtonIngredients(
                              ingredient: makeOverProvider.isSearchenable.value
                                  ? makeOverProvider
                                  .ingredientsfilteredlist[index]
                                  : makeOverProvider.ingredients[index],
                              active: makeOverProvider.isSearchenable.value
                                  ? makeOverProvider
                                  .ingredientsfilteredlist[index].isSelect
                                  : makeOverProvider.ingredients[index].isSelect,
                              choice: makeOverProvider.isSearchenable.value
                                  ? makeOverProvider
                                  .ingredientsfilteredlist[index].ingredient
                                  .toString()
                                  : makeOverProvider.ingredients[index].ingredient
                                  .toString(),
                              rebuildCallback: () {},
                              nextQuestionOnResponse: (
                                  {String? additionalAnswer}) {
                                if (additionalAnswer != null) {
                                  // ignore: unnecessary_statements
                                  ('${makeOverProvider.ingredients[index]} : $additionalAnswer');
                                } else {
                                  // widget.answer(choice);
                                }
                              },
                            ),
                          ),
                        );
                    },
                  ),
                );
              })
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                        () => QuestionCounter(
                      current: makeOverProvider.currentQuestion.value + 1,
                      total: 12,
                    ),
                  ),
                  Obx(
                        () => makeOverProvider.question == null
                        ? Container()
                        : QuestionText(
                      questionText:
                      makeOverProvider.question.value.question,
                    ),
                  ),
                  // ignore: todo
                  //TODO: Add option buttons
                  Obx(
                        () => _QuestionChoices(
                      answer: (String answer) {
                        // Get.find<TryItOnProvider>().seye(makeOverProvider.questions[6].answer[0]??"");
                        // Get.find<TryItOnProvider>().scolorD(makeOverProvider.questions[7].answer[0]??"");
                        // Get.find<TryItOnProvider>().shair(makeOverProvider.questions[8].answer[0]??"");
                        // Get.find<TryItOnProvider>().sskin(makeOverProvider.questions[9].answer[0]??"");
                        // Get.find<TryItOnProvider>().slip(makeOverProvider.questions[10].answer[0]??"");
                        makeOverProvider.question.value.setAnswer(answer);
                        print(
                            "ans====value=======${makeOverProvider.questions[6].answer}");
                        setState(() {});
                      },
                      choiceMap: makeOverProvider.question.value.choices,
                      answerList: makeOverProvider.question.value.getAnswer(),
                      nextQuestionOnResponse: () {
                        // Provider.of<MakeOverProvider>(context, listen: false).nextQuestion(false);
                        makeOverProvider.nextQuestion(false);
                        makeOverProvider.update();
                        // if(makeOverProvider.question.value.choices.length>2)
                        // {}
                        // else if(makeOverProvider.question.value.choices.length>2)
                        // {

                        // }
                      },
                    ),
                  )
                  ]));
  }
}

class _QuestionChoices extends StatefulWidget {
  final Function nextQuestionOnResponse;
  final Function answer;
  final Map<String, dynamic> choiceMap;
  final List<String?> answerList;
  final List<String> choiceList = [];

  _QuestionChoices(
      {required this.choiceMap,
      required this.nextQuestionOnResponse,
      required this.answer,
      required this.answerList}) {
    choiceMap.forEach((String key, dynamic value) {
      choiceList.add(value);
    });
  }

  @override
  __QuestionChoicesState createState() => __QuestionChoicesState();
}

class __QuestionChoicesState extends State<_QuestionChoices>
    with SingleTickerProviderStateMixin {
  late final controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  late final animation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(controller);

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.choiceList.map<_ChoiceButton>(
              (String choice) {
                bool active = false;

                if (widget.answerList.contains("\"$choice\"")) {
                  active = true;
                }

                return _ChoiceButton(
                  active: active,
                  choice: choice,
                  rebuildCallback: () {
                    setState(() {});

                    // on tap set choice
                    switchaDD(makeOverProvider.currentQuestion.value, choice);
                    print("get choice:: $choice");
                  },
                  nextQuestionOnResponse: ({String? additionalAnswer}) {
                    if (additionalAnswer != null) {
                      widget.answer('$choice : $additionalAnswer');
                    } else {
                      widget.answer(choice);
                    }
                    widget.nextQuestionOnResponse();
                  },
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }

  /*****************************************************************
      PROGRAM: Store choice data
      AUTHOR: kishan
      LOGON ID: Z?????? (your Z number here)
      DUE DATE:  due date of program
      FUNCTION: set choice as per question number and store in variable
      INPUT: standard question number and choice
      OUTPUT: set answer choice
      NOTES: storing choice as per question number
   ****************************************************************/
  switchaDD(int value, String choice) {
    switch (value) {
      // case 0:
      //   {
      //     Get.find<TryItOnProvider>().sDoctorCare(choice);
      //     print(
      //         " Color choice$value :::: ${Get.find<TryItOnProvider>().doctorCare}");
      //     break;
      //   }
      // case 1:
      //   {
      //     // Get.find<TryItOnProvider>().slip(choice);
      //     // print(" Color choice$value :::: ${Get.find<TryItOnProvider>().lip}");
      //     break;
      //   }
      // case 2:
      //   {
      //     // Get.find<TryItOnProvider>().slip(choice);
      //     // print(" Color choice$value :::: ${Get.find<TryItOnProvider>().lip}");
      //     break;
      //   }
      // case 3:
      //   {
      //     // Get.find<TryItOnProvider>().slip(choice);
      //     // print(" Color choice$value :::: ${Get.find<TryItOnProvider>().lip}");
      //     break;
      //   }
      // case 4:
      //   {
      //     // Get.find<TryItOnProvider>().slip(choice);
      //     // print(" Color choice$value :::: ${Get.find<TryItOnProvider>().lip}");
      //     break;
      //   }
      // case 5:
      //   {
      //     // Get.find<TryItOnProvider>().slip(choice);
      //     // print(" Color choice$value :::: ${Get.find<TryItOnProvider>().lip}");
      //     break;
      //   }
      // case 6:
      //   {
      //     // Get.find<TryItOnProvider>().slip(choice);
      //     // print(" Color choice$value :::: ${Get.find<TryItOnProvider>().lip}");
      //     break;
      //   }
      // case 7:
      //   {
      //     // Get.find<TryItOnProvider>().slip(choice);
      //     // print(" Color choice$value :::: ${Get.find<TryItOnProvider>().lip}");
      //     break;
      //   }
      case 8:
        Get.find<TryItOnProvider>().slip(choice);
        print(" Color choice$value :::: ${Get.find<TryItOnProvider>().lip}");
        break;

      case 9:
        Get.find<TryItOnProvider>().sskin(choice);
        print(" Color choice$value :::: ${Get.find<TryItOnProvider>().skin}");
        break;

      case 10:
        Get.find<TryItOnProvider>().seye(choice);
        print(" Color choice$value :::: ${Get.find<TryItOnProvider>().eye}");
        break;

      case 11:
        Get.find<TryItOnProvider>().shair(choice);
        print(" Color choice$value :::: ${Get.find<TryItOnProvider>().hair}");
        break;

      default:
        {
          Get.find<TryItOnProvider>().slip(choice);
          print(" Color choice$value :::: ${Get.find<TryItOnProvider>().lip}");
          break;
        }
    }
  }
}

class _ChoiceButton extends StatefulWidget {
  final Function nextQuestionOnResponse;
  final bool active;
  final Function rebuildCallback;

  final String choice;

  _ChoiceButton({
    Key? key,
    required this.choice,
    required this.nextQuestionOnResponse,
    required this.active,
    required this.rebuildCallback,
  }) : super(key: key);

  @override
  State<_ChoiceButton> createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<_ChoiceButton> {
  final MakeOverProvider controller = Get.find<MakeOverProvider>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: CapsuleButton(
        height: 42,
        borderColor: Color(0xFF2B2626),
        backgroundColor: widget.active ? Color(0xFF2B2626) : Colors.black,
        onPress: () async {
          if (widget.choice.toLowerCase() == 'medications' ||
              widget.choice.toLowerCase() == 'health check') {
            String response = await _getUserResponse(context, widget.choice);
            print("niiillllll :: $response");
            // Get.find<TryItOnProvider>().seye(response);
            // Get.find<TryItOnProvider>().slip(response);
            // Get.find<TryItOnProvider>().sskin(response);
            // Get.find<TryItOnProvider>().shair(response);
            widget.nextQuestionOnResponse(additionalAnswer: response);
            controller.switchType();
          } else {
            widget.nextQuestionOnResponse();
          }
          setState(() {});
          widget.rebuildCallback();
        },
        child: Text(
          '${widget.choice.toUpperCase()}',
          overflow: TextOverflow.fade,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: AppColors.primaryColor,
                letterSpacing: 0.7,
                fontSize: 14,
              ),
        ),
      ),
    );
  }

  Future<String> _getUserResponse(BuildContext c, String title) async {
    TextEditingController _textFieldController = TextEditingController();

    await showDialog(
      context: c,
      barrierDismissible: false,
      builder: (context) {
        return _UserResponseDialog(
          controller: _textFieldController,
          title: title,
        );
      },
    );
    return _textFieldController.value.text;
  }
}

class _ChoiceButtonIngredients extends StatefulWidget {
  final Function nextQuestionOnResponse;
  final bool active;
  final Function rebuildCallback;
  final Ingredients ingredient;

  final String choice;

  _ChoiceButtonIngredients({
    Key? key,
    required this.choice,
    required this.nextQuestionOnResponse,
    required this.active,
    required this.rebuildCallback,
    required this.ingredient,
  }) : super(key: key);

  @override
  State<_ChoiceButtonIngredients> createState() =>
      _ChoiceButtonIngredientsState();
}

class _ChoiceButtonIngredientsState extends State<_ChoiceButtonIngredients> {
  final MakeOverProvider controller = Get.find<MakeOverProvider>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: CapsuleButton(
        height: 42,
        borderColor: Color(0xFF2B2626),
        backgroundColor:
            widget.ingredient.isSelect ? Colors.white : Colors.black,
        onPress: () async {
          if (widget.ingredient.ingredient.toLowerCase() == "none") {
            //  widget.ingredient.isSelect = true;
            makeOverProvider.ingredients.forEach((element) {
              element.isSelect = false;
            });
            makeOverProvider.ingredients[0].isSelect = true;
            makeOverProvider.ingredients.refresh();
            //makeOverProvider.nextQuestion(false);
          } else if (widget.ingredient.isSelect == false) {
            makeOverProvider.ingredients[0].isSelect = false;
            widget.ingredient.isSelect = true;

            makeOverProvider.ingredients.refresh();
            //  setState(() {  makeOverProvider.ingredients[0].isSelect = false;});
            // if (widget.ingredient.ingredient.toString().toLowerCase() !=
            //     "none") {

            // }
          } else {
            widget.ingredient.isSelect = false;
          }

          setState(() {});
          widget.rebuildCallback();
        },
        child: Text(
          '${widget.choice.toUpperCase()}',
          overflow: TextOverflow.fade,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: widget.ingredient.isSelect
                    ? Colors.black
                    : AppColors.primaryColor,
                letterSpacing: 0.7,
                fontSize: 14,
              ),
        ),
      ),
    );
  }

// Future<String> _getUserResponse(BuildContext c, String title) async {
//   TextEditingController _textFieldController = TextEditingController();

//   await showDialog(
//     context: c,
//     barrierDismissible: false,
//     builder: (context) {
//       return _UserResponseDialog(
//         controller: _textFieldController,
//         title: title,
//       );
//     },
//   );
//   return _textFieldController.value.text;
// }

}

class _UserResponseDialog extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  _UserResponseDialog({Key? key, required this.controller, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 220,
        // height: 220,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
        color: Color(0xFFF2CA8A),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                '$title',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF707070)),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(),
                minLines: 7,
                maxLines: 7,
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: CapsuleButton(
                onPress: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'SAVE',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        letterSpacing: 0,
                      ),
                ),
                width: 88,
                height: 23,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserResponseDialog extends StatelessWidget {
  final String body;
  final String title;
  final VoidCallback ontap;

  UserResponseDialog(
      {Key? key, required this.body, required this.title, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: Color(0xFF707070)),
          borderRadius: BorderRadius.circular(30),
          color: Colors.black,
        ),
        width: 220,
        // height: 220,
        // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  '$title',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Color(0xFFF2CA8A),
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              //  SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      //  border: Border.all(color: Color(0xFF707070)),
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$body',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Color(0xFFF2CA8A),
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: ontap,
                child: Container(
                  height: 40,
                  width: Get.width * 0.2,
                  decoration: BoxDecoration(
                      color: Color(0xffF2CA8A),
                      borderRadius: BorderRadius.circular(50)),
                  alignment: Alignment.center,
                  child: Text(
                    "ok",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: CapsuleButton(
              //     onPress: ontap,
              //     child: Text(
              //       'SAVE',
              //       style: Theme.of(context).textTheme.headline2!.copyWith(
              //             color: Colors.white,
              //             fontSize: 12,
              //             letterSpacing: 0,
              //           ),
              //     ),
              //     width: 88,
              //     height: 23,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
