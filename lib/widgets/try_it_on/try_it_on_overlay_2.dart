// // ignore_for_file: deprecated_member_use
//
// import 'dart:async';
// import 'dart:io';
//
// import 'package:blinking_text/blinking_text.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:sofiqe/controller/controllers.dart';
// import 'package:sofiqe/controller/looksController.dart';
// import 'package:sofiqe/controller/ms8Controller.dart';
// import 'package:sofiqe/controller/nav_controller.dart';
// import 'package:sofiqe/controller/selectedProductController.dart';
// import 'package:sofiqe/model/ms8Model.dart';
// import 'package:sofiqe/model/new_product_model.dart';
// import 'package:sofiqe/model/searchAlternativecolorModel.dart';
// import 'package:sofiqe/model/selectedProductModel.dart';
// import 'package:sofiqe/provider/account_provider.dart';
// import 'package:sofiqe/provider/make_over_provider.dart';
// import 'package:sofiqe/provider/try_it_on_provider.dart';
// // import 'package:sofiqe/utils/states/function.dart';
// import 'package:sofiqe/widgets/capsule_button.dart';
// import 'package:sofiqe/widgets/png_icon.dart';
// import 'package:sofiqe/widgets/round_button.dart';
// import 'package:sofiqe/widgets/try_it_on/try_it_on_buttons.dart';
// import 'package:sofiqe/widgets/try_on_Lookproduct.dart';
// import 'package:sofiqe/widgets/try_on_product.dart';
//
// import '../../model/CentralColorLeftmostModel.dart';
// import '../../model/product_model.dart';
// import '../../provider/cart_provider.dart';
// // import '../../provider/page_provider.dart';
// import '../../screens/shopping_bag_screen.dart';
// import '../product_detail/order_notification.dart';
//
// class TryItOnOverlay2 extends StatefulWidget {
//   final CameraController camera;
//
//   const TryItOnOverlay2({Key? key, required this.camera}) : super(key: key);
//
//   @override
//   _TryItOnOverlay2State createState() => _TryItOnOverlay2State();
// }
//
// class _TryItOnOverlay2State extends State<TryItOnOverlay2>
//     with TickerProviderStateMixin {
//   late final AnimationController _controller = AnimationController(
//     duration: const Duration(milliseconds: 200),
//     vsync: this,
//   );
//
//   bool vis = false;
//   late final Animation<double> _animation = CurvedAnimation(
//     parent: _controller,
//     curve: Curves.linear,
//   );
//   final TryItOnProvider tiop = Get.find<TryItOnProvider>();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   /* timer for blinking text */
//   int timer = 0;
//
//   /* Visible and invisible time */
//   int vistime = 5;
//
//   /* bool for blink text visible or not */
//
//   @override
//   void initState() {
//     // hide Android default navigation bar
//     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
//
//     // blinking text visible for 5 sec and invisible for 10 sec
//     Timer.periodic(
//       Duration(seconds: 1),
//           (_) {
//         timer++;
//         if (timer == vistime) {
//           setState(() {
//             vistime = vistime == 5 ? 10 : 5;
//             vis = !vis;
//             timer = 0;
//           });
//         }
//       },
//     );
//
//     selectedcontroller.getSelectedProduct();
//     super.initState();
//   }
//
//   Ms8Controller controller = Get.find();
//   SelectedProductController selectedcontroller =
//   Get.find<SelectedProductController>();
//
//   bool adding = false;
//   bool open = false;
//
//   Future<bool> captureImageAndShare() async {
//     try {
//       XFile image = await widget.camera.takePicture();
//       var dir = (await getExternalStorageDirectory());
//       File file = File(join(dir!.path, 'scanned_product_try_on.jpg'));
//       if (await file.exists()) {
//         await file.delete();
//       }
//       await image.saveTo(file.path);
//       await Share.shareFiles([file.path]);
//       return true;
//     } catch (e) {
//       Get.showSnackbar(
//         GetSnackBar(
//           message: 'Error occured: $e',
//           duration: Duration(seconds: 2),
//         ),
//       );
//       return false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     // bool cameraShouldWait = false;
// // <<<<<<< HEAD
// //     var cartItems = Provider.of<CartProvider>(context).cart != null
// //         ? Provider.of<CartProvider>(context).cart!.length
// //         : 0;
// // =======
//     var cartItems = Provider.of<CartProvider>(context).itemCount;
//
//     // var totalCartQty = Provider.of<CartProvider>(context).getTotalQty();
//     String name = '';
//
//     if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
//       name =
//           Provider.of<AccountProvider>(context, listen: false).user!.firstName;
//     }
//
//     return Container(
//       width: size.width,
//       child: Column(
//         children: [
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(left: 10, top: 20),
//                   child: Material(
//                     color: Colors.transparent,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () async {
//                         if (tiop.lookname.value == "m16") {
//                           if (tiop.selectedProducts.isNotEmpty) {
//                             await tiop.saveSelectedProducts();
//                           }
//                           final MakeOverProvider mop = Get.find();
//                           mop.colorAna.value = false;
//                           mop.screen.value = 1;
//                           mop.questions.value = questionsController.makeover;
//                           Get.find<NavController>().setnavbar(false);
//                           mop.update();
//                         } else {
//                           print('Back pressed');
//                           Navigator.pop(context);
//                           Get.find<NavController>().setnavbar(false);
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       'sofiqe',
//                       style: Theme.of(context).textTheme.headline1!.copyWith(
//                         fontSize: 30,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(
//                       tiop.directProduct.value
//                           ? "TRY ON"
//                           : tiop.lookname.value == "myselection"
//                           ? "MY SELECTION"
//                           : tiop.lookname.value == "m16"
//                           ? 'COLOUR MATCHING'
//                           : "LOOKS",
//                       style: Theme.of(context).textTheme.headline2!.copyWith(
//                           fontSize: size.height * 0.018,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Obx(() {
//                       return Text(
//                         '${name.isNotEmpty ? '$name,' : ''} you looks ${tiop.lookProduct.value == true && tiop.lookname.value != "myselection" && tiop.lookname.value != "m16" ? tiop.lookname : 'sofiqe'} today',
//                         style: Theme.of(context).textTheme.headline2!.copyWith(
//                           fontSize: size.height * 0.018,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       );
//                     })
//                   ],
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(right: 10, top: 20),
// // <<<<<<< HEAD
//                   child: RoundButton(
//                     borderColor: Color(0xfff4f2f0).withOpacity(0.7),
//                     backgroundColor: Color(0xfff4f2f0).withOpacity(0.7),
// // =======
// //                   child: RoundButton(
// //                     backgroundColor: Colors.black,
// // >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
//                     size: size.height * 0.05,
//                     onPress: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (BuildContext c) {
//                             return ShoppingBagScreen();
//                           },
//                         ),
//                       );
//                     },
//                     child: Stack(
//                       alignment: Alignment.topRight,
//                       children: [
// // <<<<<<< HEAD
//                         PngIcon(image: 'assets/icons/add_to_cart_black.png'),
// // =======
// //                         PngIcon(image: 'assets/icons/add_to_cart_white.png'),
// // >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
//                         cartItems == 0
//                             ? SizedBox()
//                             : Container(
//                             decoration: BoxDecoration(
// // <<<<<<< HEAD
//                                 shape: BoxShape.circle,
//                                 color: Color.fromARGB(255, 255, 0, 0)),
//                             padding: EdgeInsets.all(5),
//                             child: Text(
//                               cartItems.toString(),
//                               style: TextStyle(
//                                   fontSize: 10,
//                                   decoration: TextDecoration.none,
//                                   color: Colors.white),
//                             ))
//
// // =======
// //                                     shape: BoxShape.circle, color: Colors.red),
// //                                 padding: EdgeInsets.all(5),
// //                                 child: Text(totalCartQty.toString()))
// // >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           TryItOnButtons(),
//           Obx(() => tiop.directProduct.value &&
//               tiop.centralLeftmostloading.isTrue
//               ? Container()
//               : Material(
//             child: Container(
//               alignment: Alignment.center,
//               width: size.width,
//               height: size.height * 0.06,
//               padding:
//               EdgeInsets.symmetric(horizontal: size.width * 0.02),
//               decoration: BoxDecoration(
//                 color: Color(0XFFFFFFFF),
//               ),
//               child: Obx(
//                     () {
//                   int count = tiop.count.value;
//
//                   // Center ADD all and blink text
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//
//
//                       // Spacer(),
//
//
//                       Expanded(
//                           child: count > 1
//                               ? Visibility(
//                                   visible: vis,
//                                   // blinking text
//                                   child: BlinkText(
//                                       count.toString() +
//                                           ' RECOMMENDATIONS',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .headline2!
//                                           .copyWith(
//                                             color: Colors.black,
//                                             fontSize: 9,
//                                             letterSpacing: 0,
//                                           ),
//                                       beginColor: Colors.black,
//                                       endColor: Colors.white,
//                                       times: 100000000,
//                                       duration: Duration(seconds: 6)),
//                                 )
//                               : Container(
//                                   width: 100,
//                                 )),
//
//                       // Center ADD all and blink text
//                       Expanded(
//                           child: CapsuleButton(
//                             onPress: () async {
//                               // show loader
//                               tiop.showLoaderDialog(context);
//                               setState(() {
//                                 adding = true;
//                               });
//                               try {
//                                 tiop.lookname.value == "myselection"
//                                     ? selectedcontroller
//                                     .selectedProduct!.items!
//                                     .forEach((element) async {
//                                   CartProvider cartP =
//                                   Provider.of<CartProvider>(context,
//                                       listen: false);
//                                   print(
//                                       "CartProvider  -->> SSs ${cartP.cartToken}");
//                                   await cartP.addHomeProductsToCart(
//                                       context,
//                                       Product(
//                                           id: int.parse(element
//                                               .product!.entityId!),
//                                           name: element.product!.name,
//                                           sku: element.product!.sku,
//                                           price: double.parse(
//                                               element.product!.price!),
//                                           image:
//                                           element.product!.image!,
//                                           description: element
//                                               .product!.description!,
//                                           faceSubArea: int.parse(element
//                                               .product!.faceSubArea!),
//                                           avgRating: element
//                                               .product!.avgrating!));
//                                 })
//                                     : tiop.lookname.value == "m16"
//                                     ? tiop.centralcolorleftmostselected
//                                     .forEach((element) async {
//                                   CartProvider cartP =
//                                   Provider.of<CartProvider>(
//                                       context,
//                                       listen: false);
//                                   print(
//                                       "CartProvider  -->> SSs ${cartP.cartToken}");
//                                   tiop.showLoaderDialog(context);
//
//                                   // Add all product from make over screen
//                                   await cartP
//                                       .addHomeProductsToCartForOverlay(
//                                       context,
//                                       NewProductModel(
//                                           id: int.parse(element
//                                               .entityId!),
//                                           name: element.name,
//                                           sku: element.sku,
//                                           price: double.parse(
//                                               element.price!),
//                                           image: element.image!,
//                                           description: element
//                                               .description!,
//                                           faceSubArea: element
//                                               .faceSubArea!,
//                                           avgRating: "0"));
//
//                                   // hide loader
//                                   Navigator.canPop(context)
//                                       ? Navigator.pop(context)
//                                       : null;
//
//                                   // product snack bar
//                                   ScaffoldMessenger.of(context)
//                                       .showSnackBar(
//                                     SnackBar(
//                                       padding: EdgeInsets.all(0),
//                                       backgroundColor: Colors.black,
//                                       duration:
//                                       Duration(seconds: 1),
//                                       content: Container(
//                                         child: CustomSnackBar(
//                                           sku: element.sku!,
//                                           image: element.image!
//                                               .replaceAll(RegExp(
//                                             // 'https://dev.sofiqe.com/media/catalog/product'),
//                                               'https://sofiqe.com/media/catalog/product'), ''),
//                                           name: element.name!,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                   Navigator.canPop(context)
//                                       ? Navigator.pop(context)
//                                       : null;
//                                 })
//                                     : controller.ms8model!.itemData!
//                                     .forEach((element) async {
//                                   CartProvider cartP =
//                                   Provider.of<CartProvider>(
//                                       context,
//                                       listen: false);
//                                   print(
//                                       "CartProvider  -->> SSs ${cartP.cartToken}");
//                                   await cartP.addHomeProductsToCart(
//                                       context,
//                                       Product(
//                                           id: int.parse(
//                                               element.entityId!),
//                                           name: element.name,
//                                           sku: element.sku,
//                                           price: double.parse(
//                                               element.price!),
//                                           image: element.image!,
//                                           description:
//                                           element.description!,
//                                           faceSubArea: int.parse(
//                                               element.faceSubArea!),
//                                           avgRating: "0"));
//                                 });
//
//                                 if (tiop.lookname.value != "myselection" &&
//                                     tiop.lookname.value != "m16") {
//                                   LooksController looksController =
//                                   Get.put(LooksController());
//                                   int skuindex = looksController
//                                       .lookModel!.items!
//                                       .indexWhere((element) =>
//                                   element.name ==
//                                       tiop.lookname.value);
//                                   await Provider.of<CartProvider>(context,
//                                       listen: false)
//                                       .addToCart(
//                                       context,
//                                       looksController.lookModel!
//                                           .items![skuindex].sku!,
//                                       [],
//                                       1,
//                                       tiop.lookname.value);
//                                 }
//                               } catch (err) {
//                                 print(err);
//                                 print("cart errorr");
//                               } finally {
//                                 setState(() {
//                                   adding = false;
//                                 });
//                               }
//                             },
//                             height: size.height * 0.04,
//                             child: adding == true
//                                 ? Center(
//                               child:
//                               SpinKitDoubleBounce(
//                                 color: Color(0xffF2CA8A),
//                                 size: 30.0,
//                               ),
//                               // CircularProgressIndicator(),
//                             )
//                                 : Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 PngIcon(
//                                   image:
//                                   'assets/icons/add_to_cart_yellow.png',
//                                 ),
//                                 SizedBox(width: size.width * 0.012),
//                                 Text(
//                                   'ADD ALL',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headline2!
//                                       .copyWith(
//                                     color: Colors.white,
//                                     fontSize: size.height * 0.012,
//                                     letterSpacing: 0,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )),
//                       Expanded(
//                           child: Container(
//                               alignment: Alignment.centerRight,
//                               child: IconButton(
//                                 onPressed: () async {
//                                   if (tiop.bottomSheetVisible.value) {
//                                     await _controller.reverse();
//                                     tiop.toggleBottomSheetVisibility();
//                                   } else {
//                                     tiop.toggleBottomSheetVisibility();
//                                     await _controller.forward();
//                                   }
//                                 },
//                                 icon: PngIcon(
//                                   image: tiop.bottomSheetVisible.value
//                                       ? 'assets/icons/push_down_black.png'
//                                       : 'assets/icons/push_up_black.png',
//                                 ),
//                               )))
//                     ],
//                   );
//                 },
//
// // =======
// //           Container(
// //             padding: EdgeInsets.symmetric(
// //                 vertical: size.height * 0.03, horizontal: size.width * 0.03),
// //             width: size.width,
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     RoundButton(
// //                       size: size.height * 0.08,
// //                       backgroundColor: Color(0xFFF2CA8A),
// //                       onPress: () {},
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           Padding(
// //                             padding: const EdgeInsets.all(3.0),
// //                             child: SvgPicture.asset(
// //                                 'assets/svg/star_filled.svg',
// //                                 color: Colors.black),
// //                           ),
// //                           Text(
// //                             "Review".toUpperCase(),
// //                             style: TextStyle(
// //                                 fontSize: 10,
// //                                 color: Colors.black,
// //                                 decoration: TextDecoration.none),
// //                           )
// //                         ],
// //                       ),
// // >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
//               ),
//             ),
//           )),
//           Obx(() {
//             return tiop.directProduct.value
//                 ? Container(
//               height: 97,
//               color: Color(0xFFF4F2F0),
//               child: Obx(
//                     () {
//                   return TryOnProduct(
//                     product: tiop.received.value,
//                   );
//                 },
// // <<<<<<< HEAD
//               ),
//             )
//                 : SizeTransition(
//               sizeFactor: _animation,
//               axis: Axis.vertical,
//               axisAlignment: -1,
//               child: Container(
//
//                 // 1.5 row in bottom menu sheet
//                   height: tiop.selectedProduct.value == true ? 190 : 150,
//                   color: Color(0xFFF4F2F0),
//                   child: BottomSheetBody(
//                     tiop: tiop,
//                     controller: controller,
//                     selectefcontroller: selectedcontroller,
//                   )),
//             );
//           })
//         ],
//       ),
//     );
//   }
// }
//
// class BottomSheetBody extends StatefulWidget {
//   final TryItOnProvider tiop;
//   final Ms8Controller controller;
//   final SelectedProductController selectefcontroller;
//
//   BottomSheetBody(
//       {Key? key,
//         required this.tiop,
//         required this.controller,
//         required this.selectefcontroller})
//       : super(key: key);
//
//   @override
//   State<BottomSheetBody> createState() => _BottomSheetBodyState();
// }
//
// class _BottomSheetBodyState extends State<BottomSheetBody> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Obx(() {
//             return widget.tiop.lookname.value == "myselection" &&
//                 widget.tiop.selectedProduct.isTrue &&
//                 widget.tiop.centralcolor.length > 0
//                 ? BottomSheetTabs(
//               tmo: widget.tiop,
//             )
//                 : widget.tiop.selectedProduct.isTrue &&
//                 widget.tiop.lookname.value == "m16" &&
//                 widget.tiop.centralcolor.length > 0
//                 ? BottomSheetTabs(
//               tmo: widget.tiop,
//             )
//                 : Container();
//           }),
//           Expanded(
//               child: widget.tiop.lookname.value == "myselection"
//                   ? BottomSheetItemList(
//                 selectedcontroller: widget.selectefcontroller,
//                 tmo: widget.tiop,
//               )
//                   : widget.tiop.lookname.value == "m16"
//                   ? LeftMostList(
//                   controller: widget.controller, tmo: widget.tiop)
//                   : LookList(
//                 tmo: widget.tiop,
//                 controller: widget.controller,
//               )),
//
// // =======
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           Padding(
// //                             padding: const EdgeInsets.all(3.0),
// //                             child: PngIcon(
// //                               image: 'assets/icons/share/send@3x.png',
// //                               padding: EdgeInsets.zero,
// //                               height: 20,
// //                               width: 20,
// //                             ),
// //                           ),
// //                           Text(
// //                             "Share".toUpperCase(),
// //                             style: TextStyle(
// //                                 fontSize: 10,
// //                                 color: Colors.black,
// //                                 decoration: TextDecoration.none),
// //                           )
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Obx(() => tiop.directProduct.value
// //               ? Container()
// //               : Material(
// //                   child: Container(
// //                     alignment: Alignment.centerRight,
// //                     width: size.width,
// //                     height: size.height * 0.06,
// //                     padding:
// //                         EdgeInsets.symmetric(horizontal: size.width * 0.02),
// //                     decoration: BoxDecoration(
// //                       color: Color(0xFFF4F2F0),
// //                     ),
// //                     child: Obx(
// //                       () {
// //                         return IconButton(
// //                           onPressed: () async {
// //                             if (tiop.received.value.sku!.isEmpty) {
// //                               return;
// //                             }
// //                             if (tiop.bottomSheetVisible.value) {
// //                               await _controller.reverse();
// //                               tiop.toggleBottomSheetVisibility();
// //                             } else {
// //                               tiop.toggleBottomSheetVisibility();
// //                               await _controller.forward();
// //                             }
// //                           },
// //                           icon: PngIcon(
// //                             image: tiop.bottomSheetVisible.value
// //                                 ? 'assets/icons/push_down_black.png'
// //                                 : 'assets/icons/push_up_black.png',
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 )),
// //           Obx(() => tiop.directProduct.value
// //               ? Container(
// //                   height: size.height * 0.12,
// //                   color: Color(0xFFF4F2F0),
// //                   child: Obx(
// //                     () {
// //                       return TryOnProduct(
// //                         product: tiop.received.value,
// //                       );
// //                     },
// //                   ),
// //                 )
// //               : SizeTransition(
// //                   sizeFactor: _animation,
// //                   axis: Axis.vertical,
// //                   axisAlignment: -1,
// //                   child: Container(
// //                     height: size.height * 0.12,
// //                     color: Color(0xFFF4F2F0),
// //                     child: Obx(
// //                       () {
// //                         print("dfb");
// //                         return TryOnProduct(
// //                           product: tiop.received.value,
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 ))
// // >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
//         ],
//       ),
//     );
//   }
// }
//
// class BottomSheetTabs extends StatelessWidget {
//   final TryItOnProvider tmo;
//
//   const BottomSheetTabs({Key? key, required this.tmo}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * 0.06,
//       width: size.width,
//       decoration: BoxDecoration(
//         border: Border(
//           top: BorderSide(
//             color: Colors.grey[300] as Color,
//             // color: Colors.black,
//           ),
//           bottom: BorderSide(
//             color: Colors.grey[300] as Color,
//             // color: Colors.black,
//           ),
//         ),
//       ),
//       child: CentralColorSelector(tmo: tmo),
//     );
//   }
// }
//
// class CentralColorSelector extends StatelessWidget {
//   final TryItOnProvider tmo;
//
//   CentralColorSelector({Key? key, required this.tmo}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // tmo.Lookname.value == "myselection" ? tmo.getCentralColors() : null;
//     return Container(
//       child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Obx(
//                 () {
//               int code = tmo.currentSelectedArea.value;
//               List<Colorss> recom = [];
//               tmo.centralcolor.forEach((Colorss a) {
//                 recom.add(a);
//               });
//               return recom.isNotEmpty
//                   ? Row(
//                 children: [
//                   ...recom.map(
//                         (color) {
//                       return TryOnColorChoice(
//                         hex: color.colourAltHEX!,
//                         name: color.colourAltName!,
//                         code: code,
//                       );
//                     },
//                   ).toList(),
//                 ],
//               )
//                   : Container();
//             }
//             //  }
//             ,
//           )),
//     );
//   }
// }
//
// class TryOnColorChoice extends StatelessWidget {
//   final String hex;
//   final String name;
//   final int code;
//
//   TryOnColorChoice(
//       {Key? key, required this.hex, required this.name, required this.code})
//       : super(key: key);
//
//   final TryItOnProvider tmo = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GestureDetector(onTap: () {
//       print("pressss");
//       print(hex);
//       print(tmo.currentSelectedCentralColor);
//       tmo.currentSelectedcentralColorToggle(hex, name);
//     }, child: Obx(
//           () {
//         return Container(
//           padding: EdgeInsets.symmetric(
//               vertical: size.height * 0.01, horizontal: size.width * 0.01),
//           decoration: BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: tmo.currentSelectedCentralColor['name'] == name
//                     ? Color.fromRGBO(242, 202, 138, 1)
//                     : Colors.transparent,
//                 width: 1.5,
//               ),
//             ),
//           ),
//           child: Text(
//             '$name'.toUpperCase(),
//             style: Theme.of(context).textTheme.headline2!.copyWith(
//               color: Colors.black,
//               fontSize: size.height * 0.014,
//               letterSpacing: 0,
//             ),
//           ),
//         );
//       },
//     ));
//   }
// }
//
// class BottomSheetItemList extends StatefulWidget {
//   final TryItOnProvider tmo;
//   final SelectedProductController selectedcontroller;
//
//   BottomSheetItemList(
//       {Key? key, required this.selectedcontroller, required this.tmo})
//       : super(key: key);
//
//   @override
//   State<BottomSheetItemList> createState() => _BottomSheetItemListState();
// }
//
// class _BottomSheetItemListState extends State<BottomSheetItemList> {
//   bool isSelectedProductLoading = true;
//   SelectedProduct? selectedProduct;
//   List<GlobalKey> items = [];
//
//   @override
//   void initState() {
//     super.initState();
//     widget.tmo.getuserfacecolor();
//   }
//
//   Future scroll(int num) async {
//     final context = items[num].currentContext!;
//     Scrollable.ensureVisible(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return widget.selectedcontroller.loadin.isTrue ||
//           widget.tmo.centralLeftmostloading.isTrue
//           ? Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // CircularProgressIndicator(),
//               SpinKitDoubleBounce(
//                 color: Color(0xffF2CA8A),
//                 size: 30.0,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Please wait,\nwe are loading your previous selections",
//                 style: Theme.of(context).textTheme.headline2!.copyWith(
//                   color: Colors.black,
//                   fontSize: 13,
//                   letterSpacing: 0,
//                 ),
//                 textAlign: TextAlign.center,
//               )
//             ],
//           ))
//           : SingleChildScrollView(
//         child: widget.selectedcontroller.selectedProduct != null
//             ? Obx(() {
//           // widget.tmo.count.value= widget.selectedcontroller.loadin.isFalse? widget.selectedcontroller.selectedProduct!.items!.length:0;
//           List<Items> temp = [];
//           List<Items> temp3 = [];
//           List<Items> temp1 = [];
//           List<Items> temp2 = [];
// // print(widget.tmo.centralcolorleftmostselected[0]);
//           // int count = 0;
//
//           widget.selectedcontroller.selectedProduct!.items!
//               .forEach((ele) {
//             widget.tmo.centralcolorleftmostselected
//                 .forEach((element) {
//               if (element.sku == ele.product!.sku) {
//                 if (element.faceArea == "Eyes") {
//                   temp1.addIf(!temp1.contains(ele), ele);
//                   // temp.add(ele);
//                 } else if (element.faceArea == "Lips") {
//                   temp2.addIf(!temp2.contains(ele), ele);
//                 } else if (element.faceArea == "Cheeks") {
//                   temp3.addIf(!temp3.contains(ele), ele);
//                 }
//               }
//             });
//           });
//
//           if (widget.tmo.selectedFaceArea.value == "Eyes") {
//             temp = temp1;
//           } else if (widget.tmo.selectedFaceArea.value == "Lips") {
//             temp = temp2;
//           } else if (widget.tmo.selectedFaceArea.value ==
//               "Cheeks") {
//             temp = temp3;
//           }
//
//           temp.forEach((element) {
//             final name = GlobalKey();
//
//             items.add(name);
//           });
//
//           widget.tmo.count.value =
//               temp1.length + temp2.length + temp3.length;
//           return temp.length > 0 &&
//               widget.selectedcontroller.selectedProduct != null
//               ? Column(
//             children: temp
//                 .map((item) => Container(
//                 key: items[temp.indexOf(item)],
//                 child: TryOnLookProduct(
//                   scrll: scroll,
//                   index: widget.selectedcontroller
//                       .selectedProduct!.items!
//                       .indexOf(item),
//                   index1: temp.indexOf(item),
//                   product: ItemData(
//                     attributeSetId:
//                     item.product!.attributeSetId,
//                     brand: item.product!.brand,
//                     createdAt: item.product!.createdAt,
//                     dealFromDate:
//                     item.product!.dealFromDate,
//                     dealToDate: item.product!.dealToDate,
//                     description:
//                     item.product!.description,
//                     entityId: item.product!.entityId,
//                     extensionAttributes:
//                     ExtensionAttributes(
//                         avgratings:
//                         item.product!.avgrating,
//                         rewardPoints: item
//                             .product!.rewardPoints,
//                         reviewCount: item
//                             .product!.reviewCount),
//                     faceArea: item.faceSubArea,
//                     faceColor: item.product!.faceColor,
//                     faceSubArea:
//                     item.product!.faceSubArea,
//                     price: item.product!.price,
//                     hasOptions: item.product!.hasOptions,
//                     image: item.product!.image,
//                     ingredients:
//                     item.product!.ingredients,
//                     sku: item.product!.sku,
//                     name: item.product!.name,
//                     recommendedColor: "#e0119d",
//                     urlPath: item.product!.urlPath,
//                   ),
//                 )))
//                 .toList(),
//           )
//               : Center(
//             child: Text(
//               "No Products",
//               style: TextStyle(
//                   fontSize: 20,
//                   decoration: TextDecoration.none,
//                   color: Colors.black),
//             ),
//           );
//         })
//             : Center(
//           child: Text(
//             "No Products",
//             style: TextStyle(
//                 fontSize: 20,
//                 decoration: TextDecoration.none,
//                 color: Colors.black),
//           ),
//         ),
//       );
//     });
//   }
// }
//
// class LookList extends StatefulWidget {
//   final TryItOnProvider tmo;
//
//   final Ms8Controller controller;
//
//   LookList({Key? key, required this.controller, required this.tmo})
//       : super(key: key);
//
//   @override
//   State<LookList> createState() => _LookListState();
// }
//
// class _LookListState extends State<LookList> {
//   getdata() async {
//     await widget.controller.getLookList(widget.tmo.lookname.value);
//   }
//
//   List<GlobalKey> items = [];
//
//   @override
//   void initState() {
//     getdata();
//     super.initState();
//   }
//
//   Future scroll(int num) async {
//     final context = items[num].currentContext!;
//     Scrollable.ensureVisible(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return widget.tmo.lookloading.isTrue
//           ? Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Swirl Text
//               // CircularProgressIndicator(),
//               SpinKitDoubleBounce(
//                 color: Color(0xffF2CA8A),
//                 size: 30.0,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Center(
//                 child: Text(
//                   "Please wait,\nwe are collecting your\npersonal colours",
//                   style: Theme.of(context).textTheme.headline2!.copyWith(
//                     color: Colors.black,
//                     fontSize: 13,
//                     letterSpacing: 0,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               )
//             ],
//           ))
//           : SingleChildScrollView(
//         child: Container(child: Obx(() {
//           List<ItemData>? temp = [];
//           temp = widget.controller.ms8model?.itemData!
//               .where((element) =>
//           element.faceArea == widget.tmo.selectedFaceArea.value)
//               .toList();
//           print("temp");
//           items = [];
//           temp?.forEach((element) {
//             final name = GlobalKey();
//             items.add(name);
//           });
//           widget.tmo.count.value =
//               widget.controller.ms8model?.itemData!.length ?? 0;
//           return temp != null
//               ? Column(
//             children: temp.length < 1
//                 ? [
//               SizedBox(
//                 height: 10,
//               ),
//               SpinKitDoubleBounce(
//                 color: Color(0xffF2CA8A),
//                 size: 30.0,
//               ),
//               // CircularProgressIndicator(),
//             ]
//                 : temp
//                 .map((item) => Container(
//                 key: items[temp!.indexOf(item)],
//                 child: TryOnLookProduct(
//                   index1: temp.indexOf(item),
//                   scrll: scroll,
//                   index: temp.indexOf(item),
//                   product: item,
//                 )))
//                 .toList(),
//           )
//               : Center(
//             child: Text(
//               "No Products",
//               style: TextStyle(
//                   fontSize: 20,
//                   decoration: TextDecoration.none,
//                   color: Colors.black),
//             ),
//           );
//         })),
//       );
//     });
//   }
// }
//
// class LeftMostList extends StatefulWidget {
//   final TryItOnProvider tmo;
//
//   final Ms8Controller controller;
//
//   LeftMostList({Key? key, required this.controller, required this.tmo})
//       : super(key: key);
//
//   @override
//   State<LeftMostList> createState() => _LeftMostListState();
// }
//
// class _LeftMostListState extends State<LeftMostList> {
//   List<GlobalKey> items = [];
//
//   /* List Of Global key */
//   List itemList = [];
//
// // fetching Api Data
//   getData() async {
//     await widget.tmo.getuserfacecolor();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     getData();
//     getItem();
//   }
//
//   Future scroll(int num) async {
//     final context = itemList[num].currentContext!;
//     Scrollable.ensureVisible(context);
//   }
//
// // fetching global key list
//   getItem() async {
//     itemList = await widget.tmo.items;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(
//         Duration(seconds: 2), () => Center(child:
//     SpinKitDoubleBounce(
//       color: Color(0xffF2CA8A),
//       size: 30.0,
//     ),
//       // CircularProgressIndicator(),
//     ));
//     return Obx(() {
//       List<FaceSubareaLeftmostListOfProducts> temp1 = [];
//       widget.tmo.centralcolorleftmostselected.forEach((element) {
//         if (element.faceArea == widget.tmo.selectedFaceArea.value) {
//           temp1.add(element);
//         }
//       });
//       // temp = widget.tmo.centralcolorleftmost
//       //     .where((p0) =>
//       // p0.faceArea == widget.tmo.selectedFaceArea.value)
//       //     .toList();
//       // temp.forEach((element) {
//       //   // temp1.add(element.faceSubareaLeftmostListOfProducts![0]);
//       //
//
//       //   element.faceSubareaLeftmostListOfProducts!.forEach((ele) {
//       //     temp1.add(ele);
//       //   });
//       // });
//       // print("temp");
//       // temp1.forEach((element) {
//       //   final name = GlobalKey();
//       //   items.add(name);
//       // });
//
//       // widget.tmo.count.value = widget.tmo.centralcolorleftmostselected.length;
//
//       return widget.tmo.centralLeftmostloading.isTrue && temp1.isEmpty
//           ? Center(
//         child:
//         SpinKitDoubleBounce(
//           color: Color(0xffF2CA8A),
//           size: 30.0,
//         ),
//         // CircularProgressIndicator(),
//       )
//           : SingleChildScrollView(
//         child: Container(
//           child: temp1.isNotEmpty
//               ? Column(
//             children: temp1
//                 .map((item) => Container(
//                 key: itemList[temp1.indexOf(item)],
//                 child: TryOnLookProduct(
//                   index1: temp1.indexOf(item),
//                   scrll: scroll,
//                   index: temp1.indexOf(item),
//                   product: ItemData(
//                       attributeSetId: item.attributeSetId,
//                       sku: item.sku,
//                       urlPath: item.urlPath,
//                       name: item.name,
//                       faceArea: item.faceSubAreaName,
//                       keyName: item.faceSubAreaName,
//                       image: item.image,
//                       recommendedColor: item.faceColor,
//                       extensionAttributes: ExtensionAttributes(
//                           rewardPoints: "0",
//                           productUrl: "",
//                           avgratings: ""),
//                       description: item.description,
//                       price: item.price,
//                       entityId: item.entityId,
//                       faceColor: item.faceColor,
//                       faceSubArea: item.faceSubArea),
//                 )))
//                 .toList(),
//           )
//               : Center(
//             child: Text(
//               "No Products",
//               style: TextStyle(
//                   fontSize: 20,
//                   decoration: TextDecoration.none,
//                   color: Colors.black),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }