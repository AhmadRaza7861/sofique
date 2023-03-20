import 'package:flutter/material.dart';

// 3rd party packages
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/states/function.dart';

class TotalAmount extends StatefulWidget {
   TotalAmount({Key? key}) : super(key: key);

  @override
  State<TotalAmount> createState() => _TotalAmountState();
}

class _TotalAmountState extends State<TotalAmount> {
  var height, size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;

    Map<String, dynamic> subTotal =
    Provider.of<CartProvider>(context).chargesList[0];
    Map<String, dynamic> deliveryCharges =
    Provider.of<CartProvider>(context).chargesList[1];
    double sum = subTotal['amount'] +
        deliveryCharges[
        'amount'];
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: height * 0.002, bottom: height * 0.002),
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ORDER TOTAL',
            style: Theme.of(context).textTheme.headline2!.copyWith(
              color: Color(0xFF000000),
              fontSize: height * 0.014,
              fontFamily: "Arial",
              letterSpacing: 0.4,
            ),
          ),
          Text(
            '${sum.toStringAsFixed(2).toProperCurrency()}',
            style: Theme.of(context).textTheme.headline2!.copyWith(
              color: Color(0xFF000000),
              fontSize: height * 0.014,
              fontFamily: "Arial",
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
