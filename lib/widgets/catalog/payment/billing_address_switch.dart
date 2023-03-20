import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillingAddressSwitch extends StatefulWidget {
  const BillingAddressSwitch({Key? key}) : super(key: key);

  @override
  _BillingAddressSwitchState createState() => _BillingAddressSwitchState();
}

class _BillingAddressSwitchState extends State<BillingAddressSwitch> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Same as shipping address',
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.black,
                fontSize: 13,
                letterSpacing: 0.55,
              ),
        ),
        CupertinoSwitch(
          activeColor: Colors.black,
          onChanged: (bool newVal) {
            setState(() {
              _value = newVal;
            });
          },
          value: _value,
        ),
      ],
    );
  }
}
