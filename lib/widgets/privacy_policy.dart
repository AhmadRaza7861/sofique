import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      width: 260,
      // height: 30,
      child: Text(
        'By using Sofiqe I agree to the Privacy Policy and Terms',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              fontSize: media.aspectRatio < 18 / 37 ? 10.5 : 7,
              letterSpacing: 0,
              color: Colors.black,
            ),
      ),
    );
  }
}
