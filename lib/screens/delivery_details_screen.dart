import 'package:flutter/material.dart';
import 'package:sofiqe/widgets/catalog/payment/delivery_details_page.dart';
// Custom packages
import 'package:sofiqe/widgets/png_icon.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  final void Function(Map<String, String>) callback;
  final String changeAddress;

  DeliveryDetailsScreen(this.changeAddress,
      /*this.changeAddress*/
      {Key? key,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.08),

        child: AppBar(
          // toolbarHeight: size.height * 0.11,
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
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white, fontSize: 25, letterSpacing: 2.5),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Text(
                'ADDRESS',
                style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
        ),
      ),
      body: DeliveryDetailsPage(changeAddress, callback: callback),
    );
  }
}