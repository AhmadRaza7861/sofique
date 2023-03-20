import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/catalog_sign_in_screen.dart';
import 'package:sofiqe/screens/checkout_screen.dart';
import 'package:sofiqe/screens/delivery_details_screen.dart';
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/utils/states/function.dart';
import 'package:sofiqe/widgets/cart/cart_price_distribution.dart';

import '../../provider/cart_provider.dart';
import '../../screens/product_detail_1_screen.dart';
import '../../utils/states/local_storage.dart';

// ignore: must_be_immutable
class ShoppingBagBottomTab extends StatelessWidget {
  ShoppingBagBottomTab({Key? key}) : super(key: key);
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    final TryItOnProvider tiop=Get.find();
    size = MediaQuery.of(context).size;
    height = size.height;
    return Container(
        child: Column(
      children: [
        Container(
          // height: 197,
          color: SplashScreenPageColors.textColor,
          child: Column(
            children: [
              CartPriceDistribution(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        // height: 56,
                        // width: 315,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape:MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                            foregroundColor: MaterialStateProperty.all(AppColors.navigationBarSelectedColor,),
                            backgroundColor:MaterialStateProperty.all(AppColors.buttonBackgroundShopping,) ,
                            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return tiop.ontapColor; //<-- SEE HERE
                                return null; // Defer to the widget's default.
                              },
                            ),
                          ),
                          // style: ElevatedButton.styleFrom(
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(30.0)),
                          //   foregroundColor:
                          //   AppColors.navigationBarSelectedColor,
                          //   backgroundColor: AppColors.buttonBackgroundShopping,
                          // ),
                          onPressed: () async {
                            tiop.isChangeButtonColor.value=true;
                            tiop.playSound();
                            Future.delayed(Duration(milliseconds: 10)).then((value)
                            {
                              tiop.isChangeButtonColor.value=false;
                              SystemChrome.setEnabledSystemUIMode(
                                  SystemUiMode.immersive);
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);

                            });
                          },
                          child: Text(
                            'Shop More',
                            textAlign: TextAlign.center,
                            style:
                            Theme.of(context).textTheme.headline2!.copyWith(
                              // color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Container(
                        // height: 56,
                        // width: 315,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape:MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                            foregroundColor:MaterialStateProperty.all(AppColors.navigationBarSelectedColor) ,
                            backgroundColor:MaterialStateProperty.all(AppColors.questionCardBackgroundColor,) ,
                            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return tiop.ontapColor; //<-- SEE HERE
                                return null; // Defer to the widget's default.
                              },
                            ),
                          ),
                          onPressed: () async {
                            tiop.isChangeButtonColor.value=true;
                            tiop.playSound();
                            Future.delayed(Duration(milliseconds: 10)).then((value)async
                            {
                              tiop.isChangeButtonColor.value=false;
                              tiop.sku.value="";

                              Map<String, dynamic> resultRegion =
                                  await sfQueryForSharedPrefData(
                                  fieldName: 'region',
                                  type: PreferencesDataType.STRING);
                              Map<String, dynamic> resultRegionId =
                                  await sfQueryForSharedPrefData(
                                  fieldName: 'region_id',
                                  type: PreferencesDataType.STRING);
                              Map<String, dynamic> resultCountryId =
                                  await sfQueryForSharedPrefData(
                                  fieldName: 'country_id',
                                  type: PreferencesDataType.STRING);
                              Map<String, dynamic> resultStreet =
                                  await sfQueryForSharedPrefData(
                                  fieldName: 'street',
                                  type: PreferencesDataType.STRING);
                              Map<String, dynamic> resultPhoneNumber =
                                  await sfQueryForSharedPrefData(
                                  fieldName: 'telephone',
                                  type: PreferencesDataType.STRING);
                              Map<String, dynamic> resultPostcode =
                                  await sfQueryForSharedPrefData(
                                  fieldName: 'postcode',
                                  type: PreferencesDataType.STRING);
                              Map<String, dynamic> resultCity =
                                  await sfQueryForSharedPrefData(
                                  fieldName: 'city',
                                  type: PreferencesDataType.STRING);
                              Map<String, dynamic> resultFirstName =
                                  await sfQueryForSharedPrefData(
                                  fieldName: 'firstname',
                                  type: PreferencesDataType.STRING);
                              Map<String, dynamic> resultLastName =
                                  await sfQueryForSharedPrefData(
                                  fieldName: 'lastname',
                                  type: PreferencesDataType.STRING);
                              Map<String, dynamic> resultEmail =
                                  await sfQueryForSharedPrefData(
                                  fieldName: 'email',
                                  type: PreferencesDataType.STRING);
                              Map<String, dynamic> resultRegionCode =
                                  await sfQueryForSharedPrefData(
                                  fieldName: 'region_code',
                                  type: PreferencesDataType.STRING);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext _) {
                                    // return OrderProcessing();
                                    if (Provider.of<AccountProvider>(context,
                                        listen: false)
                                        .isLoggedIn) {
                                      Provider.of<CartProvider>(context,
                                          listen: false)
                                          .fetchTiersList(
                                          Provider.of<AccountProvider>(
                                              context,
                                              listen: false)
                                              .customerId);

                                      if (resultRegion['found'] &&
                                          resultRegionId['found'] &&
                                          resultCountryId['found'] &&
                                          resultStreet['found'] &&
                                          resultPhoneNumber['found'] &&
                                          resultPostcode['found'] &&
                                          resultCity['found'] &&
                                          resultFirstName['found'] &&
                                          resultLastName['found'] &&
                                          resultEmail['found'] &&
                                          resultRegionCode['found']) {
                                        return CheckoutScreen();
                                      } else {
                                        return DeliveryDetailsScreen(
                                          "LOGINGUEST",
                                          callback: (Map<String, String>
                                          cardDetails) async {},
                                        );
                                      }
                                    } else {
                                      return CatalogSignInScreen();
                                    }
                                  },
                                ),
                              );

                            });

                          },
                          child: Text(
                            'NEXT',
                            textAlign: TextAlign.center,
                            style:
                            Theme.of(context).textTheme.headline2!.copyWith(
                              color: Color(0xFFF2CA8A),
                              fontSize: 16,
                              letterSpacing: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.5, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                          calcualteSplit(context),
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Color(0xFF000000),
                            fontSize: height * 0.013,
                            fontFamily: "Arial",
                            letterSpacing: 0.4,
                          ),
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 70.0,
                      child: Image.asset(
                        "assets/images/clearpay_new_latest.png",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new LearnMoreDialog();
                            },
                            fullscreenDialog: true));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          width: 18.0,
                          child: Image.asset(
                            "assets/images/information_black.png",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    ));
  }

  String calcualteSplit(BuildContext context) {
    // var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    double minusAmount = (double.parse(
            Provider.of<AccountProvider>(context, listen: false)
                .freeShippingAmount) -
        double.parse(Provider.of<CartProvider>(context)
            .chargesList[0]['amount']
            .toString()));

    double totalPrice = minusAmount > 0
        ? double.parse(Provider.of<CartProvider>(context)
            .chargesList[3]['amount']
            .toString())
        : Provider.of<CartProvider>(context).chargesList[3]['amount'] -
            Provider.of<CartProvider>(context).chargesList[1]['amount'];
    double splitAmount = totalPrice / 4;
    //  print(totalPrice);
    return "or 4 interest free installments of " +
        splitAmount.toStringAsFixed(2).toProperCurrency() +
        " with ";
  }
}
