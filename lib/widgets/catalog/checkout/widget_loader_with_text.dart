import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/constants/app_colors.dart';

class LoaderWithText extends StatelessWidget {
  const LoaderWithText({super.key, this.title = "Please Wait", required this.msg, this.showTitle = true});

  final String title;
  final String msg;
  final bool showTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpinKitDoubleBounce(
            // color: Colors.black,
            color: AppColors.primaryColor,
            size: 50.0),
        SizedBox(
          height: 10,
        ),
        if (showTitle)
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontSize: 12, letterSpacing: 0.8, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 3,
        ),
        Text(msg,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(fontSize: 12, letterSpacing: 0.8, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
