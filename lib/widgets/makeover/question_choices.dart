// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sofiqe/provider/make_over_provider.dart';
// import 'package:sofiqe/utils/constants/app_colors.dart';

// import '../capsule_button.dart';

// class QuestionChoices extends StatefulWidget {
//   final Function nextQuestionOnResponse;
//   final Function answer;
//   final Map<String, dynamic> choiceMap;
//   final List<String?> answerList;
//   final List<String> choiceList = [];
//   QuestionChoices(
//       {required this.choiceMap,
//       required this.nextQuestionOnResponse,
//       required this.answer,
//       required this.answerList}) {
//     choiceMap.forEach((String key, dynamic value) {
//       choiceList.add(value);
//     });
//   }

//   @override
//   __QuestionChoicesState createState() => __QuestionChoicesState();
// }

// class __QuestionChoicesState extends State<QuestionChoices>
//     with SingleTickerProviderStateMixin {
//   late final controller =
//       AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//   late final animation = Tween(
//     begin: 0.0,
//     end: 1.0,
//   ).animate(controller);
//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     controller.forward(from: 0.0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: animation,
//       child: Container(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: widget.choiceList.map<_ChoiceButton>(
//               (String choice) {
//                 bool active = false;

//                 if (widget.answerList.contains("\"$choice\"")) {
//                   active = true;
//                 }

//                 return _ChoiceButton(
//                   active: active,
//                   choice: choice,
//                   rebuildCallback: () {
//                     setState(() {});
//                   },
//                   nextQuestionOnResponse: ({String? additionalAnswer}) {
//                     if (additionalAnswer != null) {
//                       widget.answer('$choice : $additionalAnswer');
//                     } else {
//                       widget.answer(choice);
//                     }

//                     widget.nextQuestionOnResponse();
//                   },
//                 );
//               },
//             ).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class _ChoiceButton extends StatefulWidget {
//   final Function nextQuestionOnResponse;
//   final bool active;
//   final Function rebuildCallback;

//   final String choice;
//   _ChoiceButton({
//     Key? key,
//     required this.choice,
//     required this.nextQuestionOnResponse,
//     required this.active,
//     required this.rebuildCallback,
//   }) : super(key: key);

//   @override
//   State<_ChoiceButton> createState() => _ChoiceButtonState();
// }

// class _ChoiceButtonState extends State<_ChoiceButton> {
//   final MakeOverProvider controller = Get.find<MakeOverProvider>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
//       child: CapsuleButton(
//         height: 42,
//         borderColor: Color(0xFF2B2626),
//         backgroundColor: widget.active ? Color(0xFF2B2626) : Colors.black,
//         onPress: () async {
//           if (widget.choice.toLowerCase() == 'medications' ||
//               widget.choice.toLowerCase() == 'health check') {
//             String response = await _getUserResponse(context, widget.choice);
//             widget.nextQuestionOnResponse(additionalAnswer: response);
//             controller.switchType();
//           } else {
//             widget.nextQuestionOnResponse();
//           }
//           setState(() {});
//           widget.rebuildCallback();
//         },
//         child: Text(
//           '${widget.choice.toUpperCase()}',
//           overflow: TextOverflow.fade,
//           style: Theme.of(context).textTheme.headline2!.copyWith(
//                 color: AppColors.primaryColor,
//                 letterSpacing: 0.7,
//                 fontSize: 14,
//               ),
//         ),
//       ),
//     );
//   }

//   Future<String> _getUserResponse(BuildContext c, String title) async {
//     TextEditingController _textFieldController = TextEditingController();

//     await showDialog(
//       context: c,
//       barrierDismissible: false,
//       builder: (context) {
//         return _UserResponseDialog(
//           controller: _textFieldController,
//           title: title,
//         );
//       },
//     );
//     return _textFieldController.value.text;
//   }
// }
// class _UserResponseDialog extends StatelessWidget {
//   final TextEditingController controller;
//   final String title;
//   _UserResponseDialog({Key? key, required this.controller, required this.title})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         width: 220,
//         // height: 220,
//         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
//         color: Color(0xFFF2CA8A),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: Text(
//                 '$title',
//                 style: Theme.of(context).textTheme.headline2!.copyWith(
//                       color: Colors.black,
//                       fontSize: 16,
//                       letterSpacing: 0,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Color(0xFF707070)),
//               ),
//               child: TextField(
//                 controller: controller,
//                 decoration: InputDecoration(),
//                 minLines: 7,
//                 maxLines: 7,
//               ),
//             ),
//             SizedBox(height: 10),
//             Align(
//               alignment: Alignment.centerRight,
//               child: CapsuleButton(
//                 onPress: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text(
//                   'SAVE',
//                   style: Theme.of(context).textTheme.headline2!.copyWith(
//                         color: Colors.white,
//                         fontSize: 12,
//                         letterSpacing: 0,
//                       ),
//                 ),
//                 width: 88,
//                 height: 23,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


