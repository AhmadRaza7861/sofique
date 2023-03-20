// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// Model
import 'package:sofiqe/model/product_model.dart';
import 'package:sofiqe/model/product_model_best_seller.dart';
import 'package:sofiqe/utils/api/shopping_cart_api.dart';
import 'package:sofiqe/utils/states/local_storage.dart';

import '../model/new_product_model.dart';
import 'account_provider.dart';

class CartProvider extends ChangeNotifier {
  AccountProvider? userProvider;
  late List<Map<String, dynamic>> chargesList;
  String cartToken = '';
  List<dynamic>? cart;
  Future<List<dynamic>>? futureCart;
  Map<String, dynamic>? cartDetails;
  var itemCount = 0;
  String cartkey = "";
  late Map vipGuestPoint;
  late Map tierListMap;
  late Map spendingRules;
  late int monetaryStep;
  late int spendPoints;
  late Map vipUserPoint;
  double vipRatio = 0;
  late double totalSavingRation = 0.0;

  late int userReward = 0;
  late int customerminspendpoints = 0;
  late int customermaxspendpoints = 0;
  late int customerPoints = 0;
  late int tierID = 0;

  late bool isLoggedIn = false;
  int customerID = 0;
  late int freeShipping = 0;

  double lastSpent = 0;
  double totalSaving = 0;

  void update(login, customerID) async {
    isLoggedIn = login;
    customerID = customerID;
    await fetchCartDetails();
    notifyListeners();
  }

  CartProvider() {
    _initData();
  }

  _initData() async {
    chargesList = [
      {
        'name': 'Subtotal',
        'amount': 0,
        'display': '0',
      },
      {
        'name': 'Delivery',
        'amount': 3.95,
        'display': '3.95',
      },
      {
        'name': 'VAT',
        'amount': 0,
        'display': 'Included',
      },
      {
        'name': 'Total',
        'amount': 0,
        'display': '0',
      },
    ];

    await initializeCart();
  }

  Future<void> initializeCart() async {
    String token = await sfAPIInitializeGuestShoppingCart();
    cartToken = token;
    // print("CartToken  -->> succ $cartToken");

    await sfStoreInSharedPrefData(fieldName: 'cart-token', value: '$cartToken', type: PreferencesDataType.STRING);
    await fetchCartDetails();
    notifyListeners();
    await fetchVipCoins(0);
    notifyListeners();
  }

  Future<bool> genrateCart() async {
    Map<String, dynamic> tokenMap =
        await sfQueryForSharedPrefData(fieldName: 'user-token', type: PreferencesDataType.STRING);
    String token = tokenMap['user-token'] == null ? '' : tokenMap['user-token'];
    cartkey = await sfAPICreateCustomerCart(token);
    return true;
  }

  /****************************************************************
      FUNCTION: Loader dialog
      ARGUMENTS: set loader with color and barrier
      RETURNS: Alert dialog with loader
      NOTES: show loader dialog
   ****************************************************************/
  showLoaderDialog(BuildContext context) {
    final alert = SpinKitDoubleBounce(
      color: Colors.white,
      // color: Color(0xffF2CA8A),
      size: 50.0,
    );
    // notifyListeners();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

//   Future<bool> fetchCartDetails() async {

//       itemCount = 0;
//       if (!_isLoggedIn) {
//         cart = await sfAPIGetGuestCartList(cartToken);
//         cartDetails = await sfAPIGetGuestCartDetails(cartToken);
//       } else {
//         cartDetails = await sfAPIGetUserCartDetails();
//         cart = await sfAPIGetUserCartList();
// =======
  Future<List<dynamic>?> fetchCartDetails() async {
    // itemCount = 0;
    if (!isLoggedIn) {
      cart = await sfAPIGetGuestCartList(cartToken);
      cartDetails = await sfAPIGetGuestCartDetails(cartToken);
    } else {
      cart = await sfAPIGetUserCartList();
      cartDetails = await sfAPIGetUserCartDetails();
      // print("========CartID USER===============${cartDetails?['id']}");
    }
    if (cart!.isEmpty) {
      // print('===== Cart is Empty =======');
    } else {
      // print("=========== Current CART product at 0 = ${cart![0]} ============");
    }
    cart!.forEach((element) {
      element['children'] = [];
    });
    cart!.forEach((element) {
      if (element['price'] == 0) {
        cart!.forEach((item) {
          if (item['name'] == element['extension_attributes']['look_name']) {
            element['extension_attributes']['name'] = element['name'];
            (item['children'] as List).add(element['extension_attributes']);
          }
        });
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
      }
    });

    // print(cart);
    _setItemCount();
    calculateCartPrice();
    notifyListeners();
    return cart;
  }

  Future<List<dynamic>?> fetchCartDetailsFuture() async {
    // itemCount = 0;
    if (!isLoggedIn) {
      futureCart = sfAPIGetGuestCartList(cartToken);
      cartDetails = await sfAPIGetGuestCartDetails(cartToken);
      notifyListeners();
      return futureCart;
    } else {
      futureCart = sfAPIGetUserCartList();
      cartDetails = await sfAPIGetUserCartDetails();
      // print("========CartID USER===============${cartDetails?['id']}");
      notifyListeners();
    }
    if (cart!.isEmpty) {
      // print('===== Cart is Empty =======');
    } else {
      // print("=========== Current CART product at 0 = ${cart![0]} ============");
    }
    cart!.forEach((element) {
      element['children'] = [];
    });
    cart!.forEach((element) {
      if (element['price'] == 0) {
        cart!.forEach((item) {
          if (item['name'] == element['extension_attributes']['look_name']) {
            element['extension_attributes']['name'] = element['name'];
            (item['children'] as List).add(element['extension_attributes']);
          }
        });
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
      }
    });

    // print(cart);
    _setItemCount();
    calculateCartPrice();
    notifyListeners();
    return futureCart;
  }

  Future<int> fetchVipCoins(customerID) async {
    // print("fetchVipCoins $customerID");
    // Provider.of<AccountProvider>(context, listen: false).customerId
    try {
      itemCount = 0;
      if (!isLoggedIn) {
        vipGuestPoint = await sfAPIGetGuestVipCoins();
        if (!vipGuestPoint.containsKey('items')) {
          throw 'Key not found: items';
        }

        List itemsList = vipGuestPoint['items'];

        itemsList.forEach((element) {
          if (element['id'] == 9) {
            if (element.containsKey('tiers')) {
              List tiersList = element['tiers'];
              tiersList.forEach(
                (attribute) {
                  if (attribute['tier_id'] == 1) {
                    vipRatio = attribute['earn_points'] / attribute['monetary_step'];
                    // print("vipRatio" + vipRatio.toString());
                  }
                },
              );
            }
          }
        });
      } else {
        vipUserPoint = await sfAPIGetUserVipCoins(cartDetails!['id'], customerID);
        if (!vipUserPoint.containsKey('total_segments')) {
          throw 'Key not found: total_segments';
        }

        /*List itemsList1 = vipUserPoint['items'];
        itemsList1.forEach((element) {
          if (element['id'] == 9) {
            if (element.containsKey('tiers')) {
              List tiersList = element['tiers'];
              tiersList.forEach(
                    (attribute) {
                  if (attribute['tier_id'] == 1) {
                    vipRatio =
                        attribute['earn_points'] / attribute['monetary_step'];
                    print("vipRatio" + vipRatio.toString());
                  }
                },
              );
            }
          }
        });*/

        List itemsList = vipUserPoint['total_segments'];
        itemsList.forEach((element) {
          if (element['code'] == 'rewards-total') {
            userReward = element['value'];
          }
          if (element['code'] == 'rewards-spend-min-points') {
            customerminspendpoints = element['value'];
          }
          if (element['code'] == 'rewards-spend-max-points') {
            customermaxspendpoints = element['value'];
          }
        });
      }
      return userReward;
    } catch (err) {
      print('Error fetchVipCoins: $err');
      return 0;
    }
  }

  Future<bool> fetchTiersList(int customerId) async {
    // print("fetchVipCoins");
    // Provider.of<AccountProvider>(context, listen: false).customerId
    try {
      tierListMap = await sfAPIGetTiersList();
      if (!tierListMap.containsKey('items')) {
        throw 'Key not found: items';
      }
      if (isLoggedIn) {
        // print("VIPPOINT=$customerId");
        customerPoints = await sfAPIGetCustomerPoints(customerId);
      }

      List itemsList = tierListMap['items'];
      // bool forEachDone = false;
      itemsList.forEach((element) {
        if (element['min_earn_points'] >= customerPoints && tierID == 0) {
          tierID = element['tier_id'];
          // print("RAAAAA--" + tierID.toString());
        }
      });

      spendingRules = await sfAPISpendingRules();
      if (!spendingRules.containsKey('items')) {
        throw 'Key not found: items';
      }
      List spendingItemsList = spendingRules['items'];
      spendingItemsList.forEach((element) {
        if (element.containsKey('tiers')) {
          List tiersList = element['tiers'];
          tiersList.forEach(
            (attribute) {
              if (attribute['tier_id'] == tierID) {
                spendPoints = attribute['spend_points'];
                monetaryStep = attribute['monetary_step'];

                totalSavingRation = (monetaryStep / spendPoints).toDouble();

                // print("monetary_step" + monetaryStep.toString());
                // print("spend_points" + spendPoints.toString());
                // print("totalSavingRation" + totalSavingRation.toString());
              }
            },
          );
        }
      });

      return true;
    } catch (err) {
      print('Error fetchVipCoins: $err');
      return false;
    }
  }

  Future<void> deleteCart() async {
    if (isLoggedIn) {
      await sfRemoveFromSharedPrefData(fieldName: 'cart-token');
    } else {
      // await sfRemoveFromSharedPrefData(fieldName: 'user-token');
    }
    cart = [];
    notifyListeners();
  }

  Future<void> addToCart(BuildContext context, String sku, List simpleProductOptions, int type, String lookName,
      {bool refresh = true, int quantity = 0}) async {
    // try {
    print("CONTROLL 22");
    print(cartDetails);
    print(Provider.of<AccountProvider>(context, listen: false).isLoggedIn.toString());

    !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
        ? await sfAPIAddItemToCart(
            cartToken,
            cartDetails!['id'],
            sku,
            simpleProductOptions,
            type,
            'Guest',
            lookName,
            quantity: quantity,
          )
        : await sfAPIAddItemToCart(cartToken, cartDetails!['id'], sku, simpleProductOptions, type, 'LoggedIn', lookName,
            quantity: quantity);
    if (refresh) {
      await fetchCartDetails();
    }
    notifyListeners();
    // } catch (e) {
    //   if (refresh) {
    //     await fetchCartDetails();
    //   }
    //   notifyListeners();
    //   print('Error adding product to cart: $e');
    //   Map message = e as Map;
    //   if (message['message'].compareTo('The requested qty is not available') == 0) {
    //     Get.showSnackbar(
    //       GetSnackBar(
    //         message: 'The product is out of stock',
    //         duration: Duration(seconds: 2),
    //         isDismissible: true,
    //       ),
    //     );
    //   } else {
    //     Get.showSnackbar(
    //       GetSnackBar(
    //         message: 'Could not add product to cart',
    //         duration: Duration(seconds: 2),
    //       ),
    //     );
    //   }
    // }
  }

  Future<void> addToCartConfigurableProduct(
      BuildContext context, String sku, List configurableProductOptions, List simpleProductOptions, int type,
      {bool refresh = true, int quantity = 0}) async {
    try {
      !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
          ? await sfAPIAddItemToCartConfigurable(
              cartToken, cartDetails!['id'], sku, simpleProductOptions, configurableProductOptions, type, 'Guest',
              quantity: quantity)
          : await sfAPIAddItemToCartConfigurable(
              cartToken, cartDetails!['id'], sku, simpleProductOptions, configurableProductOptions, type, 'LoggedIn',
              quantity: quantity);
      if (refresh) {
        await fetchCartDetails();
      }
      notifyListeners();
    } catch (e) {
      if (refresh) {
        await fetchCartDetails();
      }
      notifyListeners();
      // print('Error adding product to cart: $e');
      Map message = e as Map;
      if (message['message'].compareTo('The requested qty is not available') == 0) {
        Get.showSnackbar(
          GetSnackBar(
            message: 'The product is out of stock',
            duration: Duration(seconds: 2),
            isDismissible: true,
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Could not add product to cart',
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> addHomeProductsToCart(BuildContext context, Product product) async {
    print("CONTROLL 11 ");
    await addToCart(context, product.sku!, (product.options ?? []), 0, "");
  }

// add product to cart
  Future<void> addHomeProductsToCartForOverlay(BuildContext context, NewProductModel product) async {
    await addToCart(context, product.sku!, [], 1, "");
  }

  Future<void> addHomeProductsToCartt(BuildContext context, Product1 product) async {
    addToCart(context, product.sku!, [], 1, "");
  }

  Future<void> removeFromCart(BuildContext context, String itemId, {bool refresh = true}) async {
    // showLoaderDialog(context);
    Provider.of<AccountProvider>(context, listen: false).isLoggedIn
        ? await sfAPIRemoveItemFromCart(cartToken, itemId, "LoggedIn")
        : await sfAPIRemoveItemFromCart(cartToken, itemId, "Guest");
    // Navigator.canPop(context) ? Navigator.pop(context) : null;
    // notifyListeners();
    if (refresh) {
      await fetchCartDetails();
      // Navigator.canPop(context) ? Navigator.pop(context) : null;
      // notifyListeners();
    }
    // Navigator.canPop(context) ? Navigator.pop(context) : null;
    notifyListeners();
  }

  Future<void> deleteAllFromCart(BuildContext context) async {
    // try {
    print("Delete All Called");
    print(cartDetails);
    print(Provider.of<AccountProvider>(context, listen: false).isLoggedIn.toString());

    !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
        ? await sfAPIRemoveAllItemFromCart(
            cartToken,
            'Guest',
          )
        : await sfAPIRemoveAllItemFromCart(cartDetails!['id'].toString(), 'LoggedIn');

    await fetchCartDetails();

    notifyListeners();
  }

  void _setItemCount() {
    itemCount = (cart ?? []).length;
    notifyListeners();
  }

  Future<bool> calculateCartPrice() async {
    if (cart != null) {
      // Calculate subtotal
      chargesList[0]['amount'] = 0;
      cart!.forEach(
        (item) {
          chargesList[0]['amount'] += (item['price'] * item['qty']);
        },
      );
      chargesList[0]['display'] = '${chargesList[0]['amount']}';

      // Calculate total
      chargesList[3]['amount'] = 0;
      chargesList.forEach(
        (Map<String, dynamic> charge) {
          if (charge['name'] != 'Total') {
            chargesList[3]['amount'] += charge['amount'];
          }
        },
      );
      chargesList[3]['display'] = chargesList[3]['amount'];
    }

    return true;
  }

  void setDeliverCharges(double charge) {
    chargesList[1]['amount'] = charge;
    chargesList[1]['display'] = '$charge';
    notifyListeners();
  }

  double getSumTotal() {
    return chargesList[3]['amount'];
  }

  int getTotalQty() {
    num totalQty = 0;
    (cart ?? []).forEach((element) {
      // print("element ${element['qty']}");
      totalQty += element!['qty'];
    });
    // print("total qty ::$totalQty");
    return totalQty.toInt();
  }

  int getCartLength() {
    return (cart ?? []).length;
  }
}
