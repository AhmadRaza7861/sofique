import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/utils/constants/api_tokens.dart';
import 'package:sofiqe/widgets/catalog/checkout/bonous_point_alert.dart';
// Custom packages
import 'package:sofiqe/widgets/catalog/checkout/order_overview.dart';
import 'package:sofiqe/widgets/catalog/checkout/payment_options.dart';
import 'package:sofiqe/widgets/catalog/checkout/shipping_options.dart';
import 'package:sofiqe/widgets/catalog/checkout/total_amount.dart';
import 'package:sofiqe/widgets/catalog/checkout/total_saving_amount.dart';
import 'package:sofiqe/widgets/catalog/checkout/vippoint_earning.dart';

import '../../../controller/msProfileController.dart';
import '../../../utils/api/shipping_address_api.dart';
import 'additional_charges.dart';
import 'giftcard_or_promocode.dart';

var isLoggedIn;
var size, height, width;

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Future<void> getAddress(BuildContext context) async {
    if (isLoggedIn) {
      await Provider.of<AccountProvider>(context, listen: false).getUserDetails(await APITokens.customerSavedToken);
      Provider.of<CartProvider>(context, listen: false)
          .fetchTiersList(Provider.of<AccountProvider>(context, listen: false).customerId);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoggedIn = Provider.of<CartProvider>(context, listen: false).isLoggedIn;
      if (isLoggedIn) loadData();
      MsProfileController.instance.loadShippindAdressinProvider();
    });
  }

  loadData() {
    getAddress(context);
    int id = Provider.of<AccountProvider>(context, listen: false).customerId;

    sfAPIGetBillingAddressFromCustomerID(customerId: id);
    sfAPIGetShippingAddressFromCustomerID(customerId: id);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    isLoggedIn = Provider.of<CartProvider>(context).isLoggedIn;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Container(alignment: Alignment.topCenter, child: OrderOverView()),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderOverView(),
                    AdditionalCharge(),
                    ShippingOptions(),
                    //SizedBox(height: 5),
                    TotalAmount(),
                    (isLoggedIn) ? VipPointEarn() : Container(),
                    GiftCardEarning(),
                    TotalSavingAmount(),
                    SizedBox(height: 6),
                    BonousPointAlert(),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Color(0xFFF4F2F0),
            height: 7,
          ),
          Expanded(
              child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      PaymentOptionsAndCheckout(),
                    ],
                  )))
        ],
      ),
    );
  }
}
