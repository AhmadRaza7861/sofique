import 'package:flutter/material.dart';

// Custom packges
import 'package:sofiqe/widgets/catalog/checkout/payment_options_list.dart';

class PaymentOptionsAndCheckout extends StatelessWidget {
  const PaymentOptionsAndCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: PaymentOptionsList(),
    );
  }
}
