import 'package:flutter/material.dart';

// 3rd party packages
import 'package:provider/provider.dart';

// Provider
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/states/function.dart';

// Custom packages
var size;

class AdditionalCharge extends StatelessWidget {
  AdditionalCharge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    Map<String, dynamic> _chargesList = Provider.of<CartProvider>(context).chargesList.first;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      border: Border.all(color: Colors.white)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _AdditionalChargeTemplate(charge: _chargesList),
        ],
      ),
    );
  }
}
var height;
class _AdditionalChargeTemplate extends StatelessWidget {
  final Map<String, dynamic> charge;
   _AdditionalChargeTemplate({Key? key, required this.charge}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;

    if (charge['name'] == 'Total') {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'SUB TOTAL',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Color(0xFF000000),
                  fontSize: height*0.014,
                  fontFamily: "Arial",
                  letterSpacing: 0.4,
                ),
          ),
          Text(
            '${charge['display'].toString().toProperCurrency()}',
            style: Theme.of(context).textTheme.headline2!.copyWith(
              color: Color(0xFF000000),
              fontFamily: "Arial",
              fontSize: height*0.014,
                  letterSpacing: 0.4,
                ),
          ),
        ],
      ),
    );
  }
}
