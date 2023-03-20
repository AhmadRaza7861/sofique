import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {
  final String questionText;
  const QuestionText({required this.questionText});

  @override
  __QuestionTextState createState() => __QuestionTextState();
}

class __QuestionTextState extends State<QuestionText>
    with SingleTickerProviderStateMixin {
  late final controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  late final animation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(controller);
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    Size size = MediaQuery.of(context).size;
    return FadeTransition(
      opacity: animation,
      child: Container(
        width: size.width * 0.8,
        height: 49,
        child: Text(
          '${widget.questionText}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 16,
              ),
        ),
      ),
    );
  }
}