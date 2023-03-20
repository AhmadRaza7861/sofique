import 'package:flutter/material.dart';
// Custom packages
import 'package:sofiqe/widgets/png_icon.dart';

import '../widgets/catalog/payment/payment_details_card_.dart';

class PaymentDetailsScreenPage extends StatelessWidget {
  final void Function(Map<String, dynamic>) callback;
  final String changeAddress;

  PaymentDetailsScreenPage(this.changeAddress, {Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.08),
        child: AppBar(
          leading: IconButton(
            icon: Transform.rotate(
              angle: 3.14159,
              child: PngIcon(
                image: 'assets/icons/arrow-2-white.png',
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'sofiqe',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.035,
                    letterSpacing: 0.6),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Text(
                "PAYMENT",
                style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //   toolbarHeight: size.height * 0.11,
      //   leading: Padding(
      //     padding: EdgeInsets.only(top: 30.0, left: 20),
      //     child: Container(
      //       child: IconButton(
      //         icon: Transform.rotate(
      //           angle: 3.14159,
      //           child: PngIcon(
      //             image: 'assets/icons/arrow-2-white.png',
      //           ),
      //         ),
      //         onPressed: () => Navigator.of(context).pop(),
      //       ),
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.black,
      //   title: Column(
      //     children: [
      //       Text(
      //         'sofiqe',
      //         textAlign: TextAlign.center,
      //         style: Theme.of(context)
      //             .textTheme
      //             .headline1!
      //             .copyWith(color: Colors.white, fontSize: 25, letterSpacing: 2.5),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       Text(
      //         'PAYMENT',
      //         style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1),
      //       ),
      //     ],
      //   ),
      // ),
      body: PaymentDetailsPageCard(changeAddress, callback: callback),
    );
  }
}