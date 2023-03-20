import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sofiqe/utils/constants/app_colors.dart';

import 'package:sofiqe/provider/make_over_provider.dart';

// Custom packages
import 'package:sofiqe/widgets/makeover/question.dart';
import 'package:sofiqe/widgets/makeover/make_over_tabs.dart';
import 'package:sofiqe/widgets/makeover/selfie_view_area.dart';

class CustomBottomSheet extends StatelessWidget {
  final Function capture;
  CustomBottomSheet({required this.capture});

  final MakeOverProvider mop = Get.find();

  @override
  Widget build(BuildContext context) {
 
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      child: Container(
        height: 272,
        color: AppColors.questionCardBackgroundColor,
        child: Column(
          children: [
            MakeOverTabs(),
            Expanded(
              child: Obx(() {
                if (mop.tab.value == 0)
                  return _QuestionView();
                else
                  return _SelfieView(capture: capture);
              }),
              // child: mop.tab == 0 ? _QuestionView() : _SelfieView(capture: widget.capture),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionView extends StatelessWidget {
  _QuestionView({Key? key}) : super(key: key);

  final MakeOverProvider mop = Get.find();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mop.getQuestionnaireList(),
      builder: (BuildContext _, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return QuestionArea(false);
          }
        }
        return Container();
      },
    );
  }
}

class _SelfieView extends StatelessWidget {
  final Function capture;
  _SelfieView({Key? key, required this.capture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((Duration _) {
    //   controller.jumpToPage(Provider.of<MakeOverProvider>(context, listen: false).currentQuestion);
    // });
    return SelfieViewArea(capture: this.capture);
  }
}









// class _QuestionView extends StatelessWidget {
//   final PageController controller;

//   const _QuestionView({Key? key, required this.controller}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Provider.of<MakeOverProvider>(context, listen: false).currentQuestion = 0;
//     return FutureBuilder(
//       future: Provider.of<MakeOverProvider>(context, listen: false).getQuestionnaireList(),
//       builder: (BuildContext _, AsyncSnapshot<bool> snapshot) {
//         return PageView(
//           controller: controller,
//           physics: NeverScrollableScrollPhysics(),
//           children: Provider.of<MakeOverProvider>(context, listen: false).questions.map<QuestionArea>(
//             (MakeOverQuestion q) {
//               return QuestionArea(
//                 questionObj: q,
//                 nextQuestionOnResponse: () {
//                   nextQuestionOnResponse(context, q.multiSelect);
//                 },
//               );
//             },
//           ).toList(),
//         );
//       },
//     );
//   }

//   void nextQuestionOnResponse(BuildContext c, bool multi) {
//     double currentQuestion = Provider.of<MakeOverProvider>(c, listen: false).currentQuestion;

//     if (multi) {
//       return;
//     }

//     if ((currentQuestion == 4 && Provider.of<MakeOverProvider>(c, listen: false).questions[0].getAnswer()[0] == 'No')) {
//       controller.animateToPage(controller.page!.toInt() + 2, duration: Duration(seconds: 1), curve: Curves.linear);
//       Provider.of<MakeOverProvider>(c, listen: false).changeCurrentQuestion(currentQuestion + 2);
//       return;
//     }
//     controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.linear);
//     Provider.of<MakeOverProvider>(c, listen: false).changeCurrentQuestion(currentQuestion + 1);
//   }
// }
