import 'package:flutter/material.dart';

class QuestionCounter extends StatefulWidget {
  final int current;
  final int total;
  QuestionCounter({required this.current, required this.total});

  @override
  _QuestionCounterState createState() => _QuestionCounterState();
}

class _QuestionCounterState extends State<QuestionCounter>
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

    return FadeTransition(
      opacity: animation,
      child: Container(
        child: Text(
          '${widget.current} / ${widget.total}',
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Color(0x80FFFFFF),
                letterSpacing: 1,
                fontSize: 10,
              ),
        ),
      ),
    );
  }
}