import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/make_over_provider.dart';

class SelfieViewArea extends StatelessWidget {
  final Function capture;

  SelfieViewArea({Key? key, required this.capture}) : super(key: key);

  final MakeOverProvider mop = Get.find();

  @override
  Widget build(BuildContext context) {
    // prompt = Provider.of<MakeOverProvider>(context).prompt;
    // prompt = mop.prompt;

    return Container(
      child: Obx(
        () {
          var current = mop.currentPrompt.value ?? "";
          return Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height:  20,
              ),


              _Prompt(text: mop.prompts[current]['text'] as String),
              SizedBox(
                height:  10,
              ),
              _SubText(text: mop.prompts[current]['subtext'] as String),
              SizedBox(
                height:  20,
              ),
              _Capture(
                  capture: this.capture,
                  fileName: mop.prompts[current]['file'] as String),
              SizedBox(
                height:  10,
              ),
              _Caption(),
            ],
          );
        },
      ),
    );
  }
}

class _Prompt extends StatelessWidget {
  final String text;

  const _Prompt({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Text(
        '$text',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 1.5,
            ),
      ),
    );
  }
}

class _SubText extends StatelessWidget {
  final String text;

  const _SubText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Text(
        '$text',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.white,
              fontSize: 10,
              letterSpacing: 0.7,
            ),
      ),
    );
  }
}

class _Capture extends StatelessWidget {
  final Function capture;
  final String fileName;

  _Capture({Key? key, required this.capture, required this.fileName})
      : super(key: key);

  final MakeOverProvider mop = Get.find();

  @override
  Widget build(BuildContext context) {
    bool ready = true;
    return InkWell(
      onTap: () async {
        if (ready) {
          //ready = false;
          await capture(fileName);
          mop.nextQuestion(false);
          ready = true;
        }
      },
      child: Container(
        height: 64,
        width: 64,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(
                64,
              ),
            ),
            border: Border.all(
              color: Color(0xFFF2CA8A),
              width: 2,
            )),
        child: Container(
          height: 58,
          width: 58,
          decoration: BoxDecoration(
            color: Color(0xFFF2CA8A),
            borderRadius: BorderRadius.all(
              Radius.circular(
                58,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Text(
        'SAY CHEESE',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              color: Color(0xFFF2CA8A),
              fontSize: 8,
              letterSpacing: 0.0,
            ),
      ),
    );
  }
}