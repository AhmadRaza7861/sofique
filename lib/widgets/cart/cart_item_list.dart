import 'package:flutter/material.dart';
// 3rd party packages
import 'package:provider/provider.dart';
// Provider
import 'package:sofiqe/provider/cart_provider.dart';
// Custom packages
import 'package:sofiqe/widgets/cart/cart_item.dart';

import '../../screens/product_detail_1_screen.dart';

class CartItemList extends StatefulWidget {
  const CartItemList({Key? key}) : super(key: key);

  @override
  _CartItemListState createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> cartItems = (Provider.of<CartProvider>(context).cart ?? []);
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                ...cartItems.map(
                  (dynamic i) {
                    // print("===cartItem====$i");
                    if (i['price'] == 0 &&
                        cartItems.any((element) => i['extension_attributes']['look_name'] == element['name']))
                      return Container();
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext c) {
                                return ProductDetail1Screen(sku: i['sku']);
                              },
                            ),
                          );
                        },
                        child: CartItem(item: i)
                    );
                  },
                ).toList(),
              ],
            )),
          )
        ],
      ),
    );
  }
}
