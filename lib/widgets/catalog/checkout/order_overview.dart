import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';

class OrderOverView extends StatelessWidget {
  const OrderOverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(),
          SizedBox(
            height: 10,
          )
          // CheckoutItems(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'ORDER OVERVIEW',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  letterSpacing: 0.55,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Container(
          height: 25,
          width: 120,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              foregroundColor: AppColors.navigationBarSelectedColor,
              backgroundColor: AppColors.buttonBackgroundShopping,
            ),
            onPressed: () async {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text(
              'Shop More',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 12,
                    letterSpacing: 0.8,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
