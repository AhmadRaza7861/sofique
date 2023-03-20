import 'package:flutter/material.dart';

// Custom packages
import 'package:sofiqe/widgets/capsule_button.dart';
import 'package:url_launcher/url_launcher.dart';

//! All the commented code are left for future use just in case
class CheckoutButton extends StatelessWidget {
  final Widget paymentOption;
  final Function callback;
  const CheckoutButton({
    Key? key,
    required this.paymentOption,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 23, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        child: Column(
          children: [
            CapsuleButton(
                onPress: () {
                  callback();
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  key: ValueKey(paymentOption),
                  child: paymentOption,
                )),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'By continuing you accept Sofiqes ',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        fontSize: 10,
                        letterSpacing: 0.4,
                      ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL();
                  },
                  child: Text(
                    'sales terms',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.black,
                          fontSize: 10,
                          letterSpacing: 0.4,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final String salesPolicyUrl = 'https://www.apple.com/in/shop/browse/open/salespolicies';

  void _launchURL() async {
    await launchUrl(Uri.parse(salesPolicyUrl));
  }
}
