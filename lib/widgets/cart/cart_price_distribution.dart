import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/utils/states/function.dart';

import '../../provider/account_provider.dart';

class CartPriceDistribution extends StatefulWidget {
  CartPriceDistribution({Key? key}) : super(key: key);

  @override
  _CartPriceDistributionState createState() => _CartPriceDistributionState();
}

class _CartPriceDistributionState extends State<CartPriceDistribution> {
  @override
  Widget build(BuildContext context) {
    double minusAmount = (double.parse(
            Provider.of<AccountProvider>(context, listen: false)
                .freeShippingAmount) -
        double.parse(Provider.of<CartProvider>(context)
            .chargesList[0]['amount']
            .toString()));
    Provider.of<CartProvider>(context).fetchTiersList(
        Provider.of<AccountProvider>(context, listen: false).customerId);
    return FutureBuilder(
      future: Provider.of<CartProvider>(context).calculateCartPrice(),
      builder: (BuildContext _, snapshote) {
        List<Map<String, dynamic>> charges =
            Provider.of<CartProvider>(context).chargesList;
        return Container(
          child: Column(
            children: [
              Center(
                child: Center(
                  child: Container(
                    color: Color(0xFFBBF8D1),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Checkout now and earn ',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Arial, Regular',
                              color: Color(0xFF389D5A),
                            ),
                          ),
                          Container(
                            width: 10.0,
                            child: Image.asset(
                              "assets/images/coin.png",
                            ),
                          ),
                          FutureBuilder(
                            future: Provider.of<CartProvider>(context)
                                .fetchVipCoins(Provider.of<AccountProvider>(
                                        context,
                                        listen: false)
                                    .customerId),
                            builder: (BuildContext _, snapshote) {
                              return Text(
                                getPoints(
                                            charges,
                                            snapshote.hasData
                                                ? snapshote.data
                                                : 0)
                                        .toString() +
                                    ' VIP Points for this order',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Arial, Regular',
                                  color: Color(0xFF389D5A),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  color: Color(0xFFBBF8D1),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        !Provider.of<AccountProvider>(context, listen: false)
                                .isLoggedIn
                            ? Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    'Applies only to registered customers, may vary when logged in. ',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Arial, Regular',
                                      color: Color(0xFF389D5A),
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SUBTOTAL',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Arial, Regular',
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      '${(charges[0]['amount'] as num).toDouble().toString().toProperCurrency()}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Arial, Regular',
                        color: SplashScreenPageColors.backgroundColor,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DELIVERY',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Arial, Regular',
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      minusAmount > 0
                          ? '${(charges[1]['amount'] as num).toDouble().toString().toProperCurrency()}'
                          : '${0.0.toString().toProperCurrency()}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Arial, Regular',
                        color: SplashScreenPageColors.backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 10,
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOTAL',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Arial, Bold',
                        fontWeight: FontWeight.bold,
                        color: SplashScreenPageColors.backgroundColor,
                      ),
                    ),
                    Text(
                      // '${charges[3]['amount'].toString().toProperCurrency()}',
                      minusAmount > 0
                          ? '${((charges[3]['amount'] as num)).toDouble().toString().toProperCurrency()}'
                          : '${((charges[3]['amount'] as num) - (charges[1]['amount'] as num)).toDouble().toString().toProperCurrency()}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Arial, Bold',
                        fontWeight: FontWeight.bold,
                        color: SplashScreenPageColors.backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total saving using VIP points',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Arial, Bold',
                        color: SplashScreenPageColors.backgroundColor,
                      ),
                    ),
                    Text(
                      // 'EUR ${charges[3]['amount']}',
                      '${getTotalSaving(charges).toStringAsFixed(2).toProperCurrency()}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Arial, Bold',
                        color: SplashScreenPageColors.backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int getPoints(charges, reward) {
    if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
      // print("INURUM--" + reward.toString());
      return reward;
    } else {
      double finalValue = (reward * (charges[3]['amount'] as num).toDouble());
      return finalValue.floor();
    }
  }

  double getTotalSaving(charges) {
    double finalValue =
        ((Provider.of<CartProvider>(context).totalSavingRation) *
            (charges[3]['amount'] as num).toDouble());
    Provider.of<CartProvider>(context).totalSaving = finalValue;
    return finalValue;
  }
}
