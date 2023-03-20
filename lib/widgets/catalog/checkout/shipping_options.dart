import 'package:flutter/material.dart';

// Custom packages
import 'package:sofiqe/widgets/catalog/checkout/shipping_options_checkbox_list.dart';

class ShippingOptions extends StatelessWidget {
  const ShippingOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 29),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ShippingOptionsCheckBoxList(),
    );
  }
}
