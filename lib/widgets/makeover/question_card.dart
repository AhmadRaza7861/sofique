import 'package:flutter/material.dart';
// Utils
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/widgets/makeover/make_over_tabs.dart';
// Custom packages
import 'package:sofiqe/widgets/makeover/question.dart';

class QuestionCard extends StatelessWidget {
  QuestionCard();

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
              child: QuestionArea(false),
            ),
          ],
        ),
      ),
    );
  }
}

// class _QuestionView extends StatelessWidget {
//   const _QuestionView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Provider.of<MakeOverProvider>(context, listen: false)
//           .getQuestionnaireList(),
//       builder: (BuildContext _, snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data == true) {
//             return QuestionArea(false);
//           }
//         }
//         return Container();
//       },
//     );
//   }
// }













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
