import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/widgets/capsule_button.dart';

class WarningForPatients extends StatelessWidget {
  WarningForPatients({Key? key}) : super(key: key);

  final MakeOverProvider mop = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.5,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: size.height * 0.01),
          Text(
            'DOCTORS CARE',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2!.copyWith(
              color: Color(0xFFF2CA8A),
              fontSize: size.height * 0.03,
              letterSpacing: 1.35,
            ),
          ),
          SizedBox(height: size.height * 0.008),
          Container(
            width: size.width * 0.7,
            child: Text(
              'As you are under doctors care, we cannot give you a precise recommendation of your skin conditions. We therefore recommend you to follow the doctors recommendations.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.white,
                fontSize: size.height * 0.016,
                letterSpacing: 0.55,
              ),
            ),
          ),
          Container(
            width: size.width * 0.7,
            child: Text(
              'We here advise you some skin care that can help you',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.white,
                fontSize: size.height * 0.016,
                letterSpacing: 0.55,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          CapsuleButton(
            onPress: () {
              mop.nextQuestion(true);
              mop.tab.value = 0;
            },
            width: size.width * 0.8,
            backgroundColor: Colors.white,
            child: Text(
              'CONTINUE',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.black,
                fontSize: size.height * 0.02,
                letterSpacing: 0.7,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}
