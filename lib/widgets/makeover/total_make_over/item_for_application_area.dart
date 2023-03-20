// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:sofiqe/model/product_model.dart';
// import 'package:sofiqe/provider/cart_provider.dart';
// import 'package:sofiqe/provider/total_make_over_provider.dart';
// import 'package:sofiqe/widgets/png_icon.dart';
// import 'package:sofiqe/widgets/product_detail/order_notification.dart';
// import 'package:sofiqe/widgets/product_image.dart';
// import 'package:sofiqe/utils/states/function.dart';

// import '../../../screens/product_detail_1_screen.dart';

// class ItemForApplicationArea extends StatelessWidget {
//   final ApplicationArea applicationArea;
//   ItemForApplicationArea({Key? key, required this.applicationArea})
//       : super(key: key);

//   final TotalMakeOverProvider tmo = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Obx(() {
//       bool selected = tmo.currentSelectedArea.value == applicationArea.code;
//       try {
//         List<Product> productList = applicationArea.products[
//             tmo.centralColorMap[applicationArea.code]['ColourAltHEX']];
//         List<Product> filteredProductList = <Product>[];
//         productList.forEach(
//           (p) {
//             if (applicationArea.selectedBrand.compareTo(p.brand) == 0 ||
//                 applicationArea.selectedBrand.compareTo('ALL') == 0) {
//               filteredProductList.add(p);
//             }
//           },
//         );

//         // Product product = applicationArea.products[tmo.centralColorMap[applicationArea.code]['ColourAltHEX']][0];
//         Product product = filteredProductList[0];
//         filteredProductList.forEach(
//           (p) {
//             if (p.color == applicationArea.selectedShade) {
//               product = p;
//             }
//           },
//         );

//         return GestureDetector(
//           onTap: () {
//             tmo.currentSelectedAreaToggle(applicationArea.code);
//           },
//           child: Container(
//             height: size.height * 0.12,
//             decoration: BoxDecoration(
//               color: selected ? Color(0xFFF2CA8A) : Colors.transparent,
//               border: Border(
//                 bottom: BorderSide(color: Colors.grey[300] as Color),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ItemImage(image: product.image),
//                 ItemInformation(
//                   areaName: applicationArea.name,
//                   productName: product.name!,
//                   price: product.price!,
//                 ),
//                 ColorSelector(applicationArea: applicationArea),
//                 AddToBagButton(
//                   product: product,
//                 ),
//               ],
//             ),
//           ),
//         );
//       } catch (err) {
//         print('Error rendering ItemForApplicationArea: $err');
//         return Container();
//       }
//     });
//   }
// }

// class ItemImage extends StatelessWidget {
//   final String image;
//   ItemImage({
//     Key? key,
//     required this.image,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * 0.08,
//       width: size.height * 0.08,
//       child: ProductImage(
//         imageShortPath: image,
//         height: size.height * 0.08,
//         width: size.height * 0.08,
//       ),
//     );
//   }
// }

// class ItemInformation extends StatelessWidget {
//   final String areaName;
//   final String productName;
//   final num price;
//   ItemInformation(
//       {Key? key,
//       required this.areaName,
//       required this.productName,
//       required this.price})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Container(
//       height: size.height * 0.08,
//       width: size.width * 0.28,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '${areaName.toUpperCase()}',
//             style: Theme.of(context).textTheme.headline2!.copyWith(
//                   color: Colors.black,
//                   fontSize: size.height * 0.012,
//                   letterSpacing: 0,
//                 ),
//           ),
//           Container(
//             width: size.width * 0.25,
//             child: Text(
//               '$productName',
//               softWrap: false,
//               overflow: TextOverflow.ellipsis,
//               style: Theme.of(context).textTheme.headline2!.copyWith(
//                     color: Colors.black,
//                     fontSize: size.height * 0.015,
//                     letterSpacing: 0,
//                   ),
//             ),
//           ),
//           SizedBox(height: size.height * 0.01),
//           Text(
//             '€ $price',
//             style: Theme.of(context).textTheme.headline2!.copyWith(
//                   color: Colors.black,
//                   fontSize: size.height * 0.013,
//                   letterSpacing: 0,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ColorSelector extends StatelessWidget {
//   // final int code;
//   final ApplicationArea applicationArea;
//   ColorSelector({Key? key, required this.applicationArea}) : super(key: key);

//   final TotalMakeOverProvider tmo = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     Color color = Colors.transparent;
//     if (tmo.centralColorMap.containsKey(applicationArea.code)) {
//       Map<dynamic, dynamic> currentColor =
//           tmo.centralColorMap[applicationArea.code];
//       String colorString = currentColor['ColourAltHEX'];
//       color = applicationArea.selectedShade.toColor();
//       if (applicationArea.colors.isNotEmpty) {
//         applicationArea.colors.forEach((key, value) {
//           // if (listEquals(key, currentColor)) {
//           //   color = value[0];
//           // }
//         });
//       }
//     }
//     return Row(
//       children: [
//         Container(
//           height: size.height * 0.08,
//           child: Icon(Icons.arrow_left),
//         ),
//         GestureDetector(
//           onTap: () {
//             tmo.toggleColorMenu(applicationArea.code);
//           },
//           child: Container(
//             height: size.height * 0.08,
//             width: size.width * 0.2,
//             decoration: BoxDecoration(
//               color: color,
//               border: Border.all(
//                 color: Color(0xFF707070),
//               ),
//             ),
//           ),
//         ),
//         Container(
//           height: size.height * 0.08,
//           child: Icon(Icons.arrow_right),
//         ),
//       ],
//     );
//   }
// }

// class AddToBagButton extends StatelessWidget {
//   final Product product;
//   AddToBagButton({
//     Key? key,
//     required this.product,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: size.height * 0.08,
//       child: GestureDetector(
//         onTap: () async {
//           if(product.options != null && product.options!.isNotEmpty){
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (BuildContext c) {
//                   return ProductDetail1Screen(sku: product.sku!);
//                 },
//               ),
//             );
//           }else{
//             CartProvider cartP =
//             Provider.of<CartProvider>(context, listen: false);
//             await cartP.addHomeProductsToCart(context, product);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 padding: EdgeInsets.all(0),
//                 backgroundColor: Colors.transparent,
//                 duration: Duration(seconds: 1),
//                 content: Container(
//                   child: CustomSnackBar(
//                     sku: product.sku!,
//                     image: product.image,
//                     name: product.name!,
//                   ),
//                 ),
//               ),
//             );
//           }

//         },
//         child: Container(
//           height: AppBar().preferredSize.height * 0.7,
//           width: AppBar().preferredSize.height * 0.7,
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.all(
//                 Radius.circular(AppBar().preferredSize.height * 0.7)),
//           ),
//           child: PngIcon(
//             height: AppBar().preferredSize.height * 0.3,
//             width: AppBar().preferredSize.height * 0.3,
//             image: 'assets/icons/add_to_cart_white.png',
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/total_make_over_provider.dart';
import 'package:sofiqe/widgets/png_icon.dart';

class ItemForApplicationArea extends StatelessWidget {
  final ApplicationArea applicationArea;
  ItemForApplicationArea({Key? key, required this.applicationArea}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      bool selected = tmo.currentSelectedArea.value == applicationArea.code;
      List products = tmo.productMap[applicationArea.code] as List<dynamic>;

      // if (products.isEmpty) {
      //   return Container();
      // }
      return GestureDetector(
        onTap: () {
          tmo.currentSelectedAreaToggle(applicationArea.code);
        },
        child: Container(
          height: size.height * 0.12,
          decoration: BoxDecoration(
            color: selected ? Color(0xFFF2CA8A) : Colors.transparent,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300] as Color),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemImage(),
              ItemInformation(
                areaName: applicationArea.name,
                productName: products.isNotEmpty ? products[0]['name'] : '',
                price: products.isNotEmpty ? products[0]['price'] : 0,
              ),
              ColorSelector(applicationArea: applicationArea),
              AddToBagButton(
                applicationArea: applicationArea,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ItemImage extends StatelessWidget {
  ItemImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.height * 0.08,
      child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8cAw6uXed-N3S4RvU_GqbjHiJhxaqzedyZw&usqp=CAU'),
    );
  }
}

class ItemInformation extends StatelessWidget {
  final String areaName;
  final String productName;
  final num price;
  ItemInformation({Key? key, required this.areaName, required this.productName, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // height: size.height * 0.08,
      width: size.width * 0.28,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${areaName.toUpperCase()}',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.012,
                  letterSpacing: 0,
                ),
          ),
          Container(
            width: size.width * 0.25,
            child: Text(
              '$productName',
              // 'L\'Oreal Socket',
              softWrap: true,
              // overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.height * 0.015,
                    letterSpacing: 0,
                  ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            '€ $price',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.013,
                  letterSpacing: 0,
                ),
          ),
          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: 'Earn ' +"2",
                                                              // contrl.ms8model!
                                                              //     .lookRewardPoints
                                                              //     .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 13)),
                                                      WidgetSpan(
                                                        alignment:
                                                            PlaceholderAlignment
                                                                .middle,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      2.0),
                                                          child: PngIcon(
                                                            height: 12,
                                                            width: 12,
                                                            image:
                                                                'assets/images/goldencoin.png',
                                                          ),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                          text: 'VIP points',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 13)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
        ],
      ),
    );
  }
}

class ColorSelector extends StatelessWidget {
  // final int code;
  final ApplicationArea applicationArea;
  ColorSelector({Key? key, required this.applicationArea}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color color = Colors.transparent;
    if (tmo.centralColorMap.containsKey(applicationArea.code)) {
      List currentColor = tmo.centralColorMap[applicationArea.code];
      String colorString = currentColor[0];
      final buffer = StringBuffer();
      if (colorString.length == 6 || colorString.length == 7) buffer.write('ff');
      buffer.write(colorString.replaceFirst('#', ''));

      if (applicationArea.colors.isNotEmpty) {
        applicationArea.colors.forEach((key, value) {
          if (listEquals(key, currentColor)) {
            color = value[0];
          }
        });
      }
    }
    return Column(children: [ Row(
      children: [
        Container(
          height: size.height * 0.08,
          child: Icon(Icons.arrow_left),
        ),
        GestureDetector(
          onTap: () {
            tmo.toggleColorMenu(applicationArea.code);
          },
          child: Container(
            height: size.height * 0.08,
            width: size.width * 0.2,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: Color(0xFF707070),
              ),
            ),
          ),
        ),
        Container(
          height: size.height * 0.08,
          child: Icon(Icons.arrow_right),
        ),
      ],
    ),
    SizedBox(height: 5,),
    Text("Check Ingredients",style: TextStyle(color: Colors.red,fontSize: size.height * 0.014,decoration: TextDecoration.none),)
    ],);
  }
}

class AddToBagButton extends StatelessWidget {
  final ApplicationArea applicationArea;
  AddToBagButton({Key? key, required this.applicationArea}) : super(key: key);

  final TotalMakeOverProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      // height: size.height * 0.08,
      child: GestureDetector(
        onTap: () {
          int index = tmo.indexMap[applicationArea.code] as int;
          int type = 0;
          List options = [];
          Map product = applicationArea.products[index];
          if (product['type_id'] == 'configurable') {
            type = 0;
          } else {
            type = 1;
          }
          if (product['options'].isNotEmpty) {
            product['options'].forEach(
              (optionMap) {
                options.add(
                  {
                    'optionId': type == 1 ? '${optionMap['option_id']}' : '${optionMap['attribute_id']}',
                    'optionValue': type == 1 ? '${optionMap['values'][1]['option_type_id']}' : '${optionMap['values'][2]['value_index']}',
                  },
                );
              },
            );
          }
          // Provider.of<CartProvider>(context, listen: false).addToCart(
          //   product['sku'],
          //   options,
          //   type,
          // );
          print('added to bag');
        },
        child: Container(
          height: AppBar().preferredSize.height * 0.7,
          width: AppBar().preferredSize.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(AppBar().preferredSize.height * 0.7)),
          ),
          child: PngIcon(
            height: AppBar().preferredSize.height * 0.3,
            width: AppBar().preferredSize.height * 0.3,
            image: 'assets/icons/add_to_cart_white.png',
          ),
        ),
      ),
    );
  }
}
