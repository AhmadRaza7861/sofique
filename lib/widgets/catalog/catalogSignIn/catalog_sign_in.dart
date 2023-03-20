import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
// Custom packages
import 'package:sofiqe/screens/checkout_screen.dart';
import 'package:sofiqe/screens/login_screen.dart';
import 'package:sofiqe/screens/signup_screen.dart';
// Utils
import 'package:sofiqe/utils/constants/app_colors.dart';
import 'package:sofiqe/utils/states/local_storage.dart';
import 'package:sofiqe/widgets/capsule_button.dart';

import '../../../screens/delivery_details_screen.dart';

class CatalogSignIn extends StatelessWidget {
  const CatalogSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: _CatalogSignInForm(),
    );
  }
}

class _CatalogSignInForm extends StatelessWidget {
  const _CatalogSignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 210,
          child: Text(
            'SIGN IN TO SOFIQE',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
          ),
        ),
        SizedBox(height: 18),
        Container(
          width: 230,
          child: Text(
            'Sign in or become Sofiqe member to save your purchase and get all the benefits',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                  letterSpacing: 0.55,
                ),
          ),
        ),
        SizedBox(height: 48),
        Container(
          width: 274,
          child: CapsuleButton(
            height: 50,
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext _) {
                  return LoginScreen();
                }),
              );
              if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext _) {
                      return CheckoutScreen();
                    },
                  ),
                );
              }
            },
            child: Text(
              'SIGN IN',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
        ),
        SizedBox(height: 14),
        Container(
          width: 274,
          child: CapsuleButton(
            backgroundColor: AppColors.primaryColor,
            height: 50,
            onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext _) {
                    return SignupScreen();
                  },
                ),
              );
              if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
                Provider.of<CartProvider>(context, listen: false)
                    .fetchTiersList(Provider.of<AccountProvider>(context, listen: false).customerId);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext _) {
                      return CheckoutScreen();
                    },
                  ),
                );
              }
            },
            child: Text(
              'NOT MEMBER? JOIN',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
        ),
        SizedBox(height: 78),
        Container(
          width: 274,
          child: CapsuleButton(
            backgroundColor: AppColors.transparent,
            borderColor: Color(0x4CFFFFFF),
            height: 50,
            onPress: () async {
              // var billingAddress = {};
              Map<String, dynamic> resultRegion =
                  await sfQueryForSharedPrefData(fieldName: 'region', type: PreferencesDataType.STRING);
              Map<String, dynamic> resultRegionId =
                  await sfQueryForSharedPrefData(fieldName: 'region_id', type: PreferencesDataType.STRING);
              Map<String, dynamic> resultCountryId =
                  await sfQueryForSharedPrefData(fieldName: 'country_id', type: PreferencesDataType.STRING);
              Map<String, dynamic> resultStreet =
                  await sfQueryForSharedPrefData(fieldName: 'street', type: PreferencesDataType.STRING);
              Map<String, dynamic> resultPhoneNumber =
                  await sfQueryForSharedPrefData(fieldName: 'telephone', type: PreferencesDataType.STRING);
              Map<String, dynamic> resultPostcode =
                  await sfQueryForSharedPrefData(fieldName: 'postcode', type: PreferencesDataType.STRING);
              Map<String, dynamic> resultCity =
                  await sfQueryForSharedPrefData(fieldName: 'city', type: PreferencesDataType.STRING);
              Map<String, dynamic> resultFirstName =
                  await sfQueryForSharedPrefData(fieldName: 'firstname', type: PreferencesDataType.STRING);
              Map<String, dynamic> resultLastName =
                  await sfQueryForSharedPrefData(fieldName: 'lastname', type: PreferencesDataType.STRING);
              Map<String, dynamic> resultEmail =
                  await sfQueryForSharedPrefData(fieldName: 'email', type: PreferencesDataType.STRING);
              Map<String, dynamic> resultRegionCode =
                  await sfQueryForSharedPrefData(fieldName: 'region_code', type: PreferencesDataType.STRING);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext _) {
                    return CheckoutScreen();
                    /*return GiftCardScreen(
                    orderId: "75",
                  );*/
                  }),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext _) {
                      return DeliveryDetailsScreen(
                        "LOGINGUEST",
                        callback: (Map<String, String> cardDetails) async {},
                      );
                    },
                  ),
                );
              }
            },
            child: Text(
              'CONTINUE WITHOUT ACCOUNT',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
            ),
          ),
        ),
        SizedBox(height: 81),
      ],
    );
  }
}
