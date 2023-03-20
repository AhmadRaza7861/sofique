import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/controller/controllers.dart';

// Provider
import 'package:sofiqe/provider/make_over_provider.dart';

// Custom packages
import 'package:sofiqe/widgets/png_icon.dart';

class QuestionController extends StatelessWidget {
  QuestionController({Key? key, required this.flowfromIngredients})
      : super(key: key);
  final bool flowfromIngredients;

  @override
  Widget build(BuildContext context) {
    // int currentQuestion = Provider.of<MakeOverProvider>(context).currentQuestion.toInt();
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Obx(
              () => makeOverProvider.currentQuestion.value != 0 &&
                      makeOverProvider.tab.value == 0
                  ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                      onTap: () {
                        // Provider.of<MakeOverProvider>(context, listen: false).previousQuestion(true);
                        makeOverProvider.foundAny.value = true;

                        makeOverProvider.previousQuestion(true);
                      },
                      child: _PreviousQuestion(
                        flow: flowfromIngredients,
                      ),
                    )
                  : _PlaceHolder(),
            ),
          ),
          flowfromIngredients
              ? SizedBox.shrink()
              : _Greetings(
                  flow: flowfromIngredients,
                ),
          Expanded(
            child: GetBuilder<MakeOverProvider>(
              init: MakeOverProvider(),
              builder: (mop) {
                // ignore: unrelated_type_equality_checks
                if (mop.isFirstques == false) {
                  if (mop.tab.value == 0 &&
                      (mop.question.value.answer.isNotEmpty &&
                          mop.question.value.multiSelect)) {

                    return GestureDetector(
                      onTap: () {
                        // mop.update();
                        makeOverProvider.foundAny.value = true;
                        mop.nextQuestion(true);
                      },
                      child: _NextQuestion(
                        flow: flowfromIngredients,
                      ),
                    );
                  } else if (flowfromIngredients == true) {
                    return GestureDetector(
                      onTap: () {
                        mop.nextQuestion(true);
                      },
                      child: _NextQuestion(
                        flow: flowfromIngredients,
                      ),
                    );
                  } else {
                    return _PlaceHolder();
                  }
                } else {
                  mop.isFirstques.value = false;
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceHolder extends StatelessWidget {
  _PlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 20,
    );
  }
}

class _PreviousQuestion extends StatelessWidget {
  const _PreviousQuestion({Key? key, required this.flow}) : super(key: key);
  final bool flow;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 15,
          child: Transform.rotate(
            angle: 3.14159,
            child: PngIcon(image: 'assets/icons/arrow-2-white.png'),
          ),
        ),
        SizedBox(width: 5),
        flow
            ? SizedBox.shrink()
            : Text(
                'BACK',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 1.13,
                    ),
              ),
      ],
    );
  }
}

class _Greetings extends StatelessWidget {
  const _Greetings({Key? key, required this.flow}) : super(key: key);
  final bool flow;

  @override
  Widget build(BuildContext context) {
    // double currentQuestion = Provider.of<MakeOverProvider>(context).currentQuestion;
    MakeOverProvider mop = Get.find();

    String message = '';
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (mop.currentQuestion.value == 0) {
      if (hour >= 6 && hour < 12) {
        message = 'Good moring Beauty';
      } else if (hour >= 12 && hour < 18) {
        message = 'Good afternoon Beauty';
      } else if (hour >= 18 && hour <= 23) {
        message = 'Good evening Beauty';
      } else if (hour >= 0 && hour < 6) {
        message = 'Good night Beauty';
      }
    }
    return SingleChildScrollView(
      child: Container(
        height: 60,
        child: Column(
          children: [
            // SizedBox(height: 8),
            flow
                ? SizedBox.shrink()
                : Text(
                    'sofiqe',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.white,
                          fontSize: 25,
                          letterSpacing: 2.5,
                        ),
                  ),
            Text(
              '${mop.currentQuestion.value == 0 && mop.tab.value == 0 ? message : ''}',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    letterSpacing: 0.9,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextQuestion extends StatelessWidget {
  const _NextQuestion({Key? key, required this.flow}) : super(key: key);
  final bool flow;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'NEXT',
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.white,
                fontSize: 12,
                letterSpacing: 1.13,
              ),
        ),
        SizedBox(width: 5),
        Container(
          height: 40,
          width: 15,
          child: PngIcon(image: 'assets/icons/arrow-2-white.png'),
        ),
      ],
    );
  }
}
