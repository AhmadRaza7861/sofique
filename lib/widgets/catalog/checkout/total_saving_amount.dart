import 'package:flutter/material.dart';
// 3rd party packages
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/states/function.dart';

class TotalSavingAmount extends StatelessWidget {
   TotalSavingAmount({Key? key}) : super(key: key);
  // var height,size;
  

  @override
  Widget build(BuildContext context) {
   var size = MediaQuery.of(context).size;
   var height = size.height;
   var isLoggedIn = Provider.of<CartProvider>(context).isLoggedIn;

    List<Map<String, dynamic>> charges = Provider.of<CartProvider>(context).chargesList;
    double _sum = Provider.of<CartProvider>(context).getSumTotal();
     double saving  = Provider.of<CartProvider>(context).totalSaving;

     double toPay = _sum - saving;
     Provider.of<CartProvider>(context).lastSpent = toPay;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          SizedBox(
            height: height*0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TO PAY',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Color(0xFF000000),
                  fontSize: height*0.016,
                  fontFamily: "Arial",
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '${toPay.toString().toProperCurrency()}',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFF000000),
                    fontSize: height*0.016,
                    fontFamily: "Arial",
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          SizedBox(
            height: height*0.008,
          ),
          (isLoggedIn)?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Saving',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFF000000),
                    fontSize: height*0.016,
                    fontFamily: "Arial",
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '${getTotalSaving(charges,context).toStringAsFixed(2).toProperCurrency()}',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFF000000),
                    fontSize: height*0.016,
                    fontFamily: "Arial",
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ):
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text( "Total saving if you were registered: ",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFF000000),
                    fontSize: height*0.016,
                    fontFamily: "Arial",
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold
                ),),
                Text(
                  '${getTotalSaving(charges,context).toStringAsFixed(2).toProperCurrency()}',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Color(0xFF000000),
                      fontSize: height*0.016,
                      fontFamily: "Arial",
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],),
          SizedBox(
            height: height*0.009,
          ),
        ],
      ),
    );
  }

  double getTotalSaving(charges, BuildContext context) {
    double finalValue = 0.1 * (charges[3]['amount'] as num).toDouble();
    return finalValue;
  }
}
