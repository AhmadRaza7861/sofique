// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/controller/looksController.dart';
import 'package:sofiqe/controller/ms8Controller.dart';
import 'package:sofiqe/controller/nav_controller.dart';
import 'package:sofiqe/controller/selectedProductController.dart';
import 'package:sofiqe/model/ms8Model.dart';
import 'package:sofiqe/model/new_product_model.dart';
import 'package:sofiqe/model/searchAlternativecolorModel.dart';
import 'package:sofiqe/model/selectedProductModel.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
// import 'package:sofiqe/utils/states/function.dart';
import 'package:sofiqe/widgets/capsule_button.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:sofiqe/widgets/round_button.dart';
import 'package:sofiqe/widgets/try_it_on/try_it_on_buttons.dart';
import 'package:sofiqe/widgets/try_it_on/try_it_on_color_selector.dart';
import 'package:sofiqe/widgets/try_on_Lookproduct.dart';
import 'package:sofiqe/widgets/try_on_product.dart' as tryOn;
import '../../controller/fabController.dart';
import '../../model/CentralColorLeftmostModel.dart';
import '../../model/product_model.dart';
import '../../provider/cart_provider.dart';
// import '../../provider/page_provider.dart';
import '../../screens/shopping_bag_screen.dart';
import '../../utils/constants/route_names.dart';
import '../product_error_image.dart';
// import 'blink_text_widget.dart';

class TryItOnOverlay extends StatefulWidget {
  final bool? isDetail;
  final dynamic selectShadeOption;
  final CameraController camera;

  const TryItOnOverlay({Key? key, required this.camera, this.isDetail, this.selectShadeOption}) : super(key: key);

  @override
  _TryItOnOverlayState createState() => _TryItOnOverlayState();
}

class _TryItOnOverlayState extends State<TryItOnOverlay> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );


  // bool vis = false;

  final TryItOnProvider tiop = Get.find<TryItOnProvider>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /* timer for blinking text */
  // int timer = 0;

  /* Visible and invisible time */
  // int vistime = 5;

  /* bool for blink text visible or not */

  @override
  void initState() {
    // hide Android default navigation bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

    // blinking text visible for 5 sec and invisible for 10 sec
    // Timer.periodic(
    //   Duration(seconds: 1),
    //   (_) {
    //     timer++;
    //     if (timer == vistime) {
    //       setState(() {
    //         vis = !vis;
    //         vistime = vis ? 5 : 10;
    //         timer = 0;
    //         print('${DateTime.now()}');
    //       });
    //     }
    //   },
    // );

    selectedcontroller.getSelectedProduct();
    super.initState();
  }

  Ms8Controller controller = Get.find();
  SelectedProductController selectedcontroller = Get.find<SelectedProductController>();

  bool adding = false;
  bool open = false;

  Future<bool> captureImageAndShare() async {
    try {
      XFile image = await widget.camera.takePicture();
      var dir = (await getExternalStorageDirectory());
      File file = File(join(dir!.path, 'scanned_product_try_on.jpg'));
      if (await file.exists()) {
        await file.delete();
      }
      await image.saveTo(file.path);
      await Share.shareFiles([file.path]);
      return true;
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Error occured: $e',
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: [SystemUiOverlay.top]);

    // bool cameraShouldWait = false;
// <<<<<<< HEAD
//     var cartItems = Provider.of<CartProvider>(context).cart != null
//         ? Provider.of<CartProvider>(context).cart!.length
//         : 0;
// =======
    var cartItems = Provider.of<CartProvider>(context).itemCount;

    // var totalCartQty = Provider.of<CartProvider>(context).getTotalQty();
    String name = '';

    if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
      name = Provider.of<AccountProvider>(context, listen: false).user!.firstName;
    }
//asd
    return Container(
      width: size.width,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 20),
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () async {
                        if (tiop.lookname.value == "m16") {
                          if (tiop.selectedProducts.isNotEmpty) {
                            await tiop.saveSelectedProducts();
                          }
                          final MakeOverProvider mop = Get.find();
                          mop.colorAna.value = false;
                          mop.screen.value = 1;
                          mop.questions.value = questionsController.makeover;
                          Get.find<NavController>().setnavbar(false);
                          mop.update();
                        } else {
                          print('Back pressed');
                          if(tiop.homeT1T2)
                            {
                              Get.toNamed(RouteNames.homeScreen);
                              Get.find<NavController>().setnavbar(false);
                              tiop.homeT1T2=false;
                            }
                          else
                            {
                              Navigator.pop(context);
                              Get.find<NavController>().setnavbar(false);
                            }
                        }

                        final FABController fabController = Get.find();
                        fabController.showFab.value = true;



                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'sofiqe',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                    ),
                    Text(
                      tiop.directProduct.value
                          ? "TRY ON"
                          : tiop.lookname.value == "myselection"
                              ? "MY SELECTION"
                              : tiop.lookname.value == "m16"
                                  ? 'COLOUR MATCHING'
                                  : "LOOKS",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: size.height * 0.018, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Obx(() {
                      return Text(
                        '${name.isNotEmpty ? '$name,' : ''} you look ${tiop.lookProduct.value == true && tiop.lookname.value != "myselection" && tiop.lookname.value != "m16" ? tiop.lookname : 'sofiqe'} today',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: size.height * 0.018,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      );
                    })
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 10, top: 20),
// <<<<<<< HEAD
                  child: RoundButton(
                    borderColor: Color(0xfff4f2f0).withOpacity(0.7),
                    backgroundColor: Color(0xfff4f2f0).withOpacity(0.7),
// =======
//                   child: RoundButton(
//                     backgroundColor: Colors.black,
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
                    size: size.height * 0.05,
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext c) {
                            return ShoppingBagScreen();
                          },
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        PngIcon(image: 'assets/icons/add_to_cart_black.png'),
                        cartItems == 0
                            ? SizedBox()
                            : Container(
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 255, 0, 0)),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  cartItems.toString(),
                                  style: TextStyle(fontSize: 10, decoration: TextDecoration.none, color: Colors.white),
                                ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          //Side icons
          GestureDetector(
              onTap: () {
                // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays:[SystemUiOverlay.top,SystemUiOverlay.bottom]);
              },
              child: TryItOnButtons(controller: _controller)),

          ///------Glassy Container with Color Pallet
          Obx(() {
            return tiop.directProduct.value
            // &&
            // tiop.bottomSheetVisible.value
            // !tiop.bottomSheetVisible.value
                ? Container()
                : !tiop.bottomSheetVisible.value
                ?
            // tiop.lookProduct.isTrue &&
            tiop.selectedProduct.isTrue
                ? tiop.selectedShades.isTrue
                ? Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              // height: 100,
              color: Color(0xFFF4F2F0).withOpacity(.8),
              child: Column(
                children: [
                  ///-----Tabs

                  Row(
                    children: [
                      ///------Text
                      SizedBox(
                        width: size.width * 0.22,
                        child: Text(
                          'Recommended Colours',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: size.height * 0.014,
                            letterSpacing: 0,
                          ),
                        ),
                      ),

                      ///-----Recommended Colors Tabs List
                      Expanded(
                        child: Obx(() {
                          return tiop.lookname.value == "myselection" &&
                              tiop.selectedProduct.isTrue &&
                              tiop.centralcolor.length > 0
                              ? BottomSheetTabs(
                            tmo: tiop,
                          )
                              : tiop.selectedProduct.isTrue &&
                              tiop.lookname.value == "m16" &&
                              tiop.centralcolor.length > 0
                              ? BottomSheetTabs(
                            tmo: tiop,
                          )
                              : Container();
                        }),
                      ),
                    ],
                  ),

                  ///----Alternative Colors
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///------Text
                      SizedBox(
                        width: size.width * 0.22,
                        child: Text(
                          'Alternatives in the same range',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: size.height * 0.014,
                            letterSpacing: 0,
                          ),
                        ),
                      ),

                      ///------List
                      Center(
                        child: Container(
                          child: TryItOnColorSelector(),
                        ),
                      ),

                      ///-----Add to Bag Button
                      Container(
                        height: AppBar().preferredSize.height * 0.7,
                        width: AppBar().preferredSize.height * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                          BorderRadius.all(Radius.circular(AppBar().preferredSize.height * 0.7)),
                        ),
                        child: PngIcon(
                          height: AppBar().preferredSize.height * 0.3,
                          width: AppBar().preferredSize.height * 0.3,
                          image: 'assets/icons/add_to_cart_white.png',
                        ),
                      ),
                      SizedBox(
                        width: AppBar().preferredSize.height * 0.1,),
                      // Container(
                      //   // height: 30,
                      //   // width: 30,
                      //   decoration: BoxDecoration(
                      //     color: Colors.black,
                      //     shape: BoxShape.circle
                      //   ),
                      //   child: Icon(
                      //
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
//               child: Obx(
//                     () {
//                   return TryOnProduct(
//                     product: tiop.received.value,
//                   );
//                 },
// // <<<<<<< HEAD
//               ),
            )
                : Container()
                : Container()
                : Container();
          }),


         ///----- Bottom Sheet


          tiop.directProduct.value
              ? Container(
            height: 97,
            color: Color(0xFFF4F2F0),
            child: Obx(
                  () {
                return tryOn.TryOnProduct(
                  selectShadeOption: widget.selectShadeOption,
                  isDetail: widget.isDetail,
                  product: tiop.received.value,
                );
              },
            ),
          )
              :

          Obx(() {

            int count = tiop.count.value;

            return SlidingUpPanel(
              controller: tiop.pc.value,
              maxHeight:  tiop.selectedFaceArea.value == "Lips" ?  size.height - size.height*.65  : size.height - size.height*.4,
              minHeight:  size.height * .078 ,
              isDraggable: true,
              onPanelOpened: (){
                tiop.toggleShadesIconSelection(false);
                tiop.toggleBottomSheetVisibility();
              },
              onPanelClosed: (){
                tiop.toggleShadesIconSelection(true);
                tiop.toggleBottomSheetVisibility();
              },
              // panel: Container(),
              header: Material(
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: size.height * 0.07,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  decoration: BoxDecoration(
                    color: Color(0XFFFFFFFF),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: count > 1
                            ? tiop.vis.value
                            ? Text(
                          '${count > 12 ? 12 : count} RECOMMENDATIONS',
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: 9,
                            letterSpacing: 0,
                          ),
                        )
                            : Container(
                          width: 100,
                        )
                            : Container(
                          width: 100,
                        ),
                      ),
                      // Center ADD all and blink text
                      Expanded(
                          child: Column(
                            children: [


                              SizedBox(
                                height: size.height * .005 ,
                              ),

                              Container(
                                width: 45,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.6),
                                    borderRadius: BorderRadius.circular(100)
                                ),
                              ),

                              SizedBox(
                                height: size.height * .005 ,
                              ),

                              Obx(()=>
                                  CapsuleButton(
                                    onPress: () async {
                                      tiop.sku.value="1234";
                                      tiop.isChangeButtonColor.value=true;
                                      tiop.playSound();
                                      Future.delayed(Duration(milliseconds: 200)).then((value)async
                                      {
                                        tiop.isChangeButtonColor.value=false;
                                        tiop.sku.value="";

                                        print("ENTER 00  ${tiop.lookname.value}");
                                        // show loader
                                        tiop.showLoaderDialog(context);
                                        setState(() {
                                          adding = true;
                                        });
                                        try {
                                          tiop.lookname.value == "myselection"
                                              ? AddToCardMySelection(context)
                                              : tiop.lookname.value == "m16"
                                              ? AddToCardm16(context)
                                              : controller.ms8model!.itemData!.forEach((element) async {
                                            CartProvider cartP = Provider.of<CartProvider>(context, listen: false);
                                            print("CartProvider  -->> SSs ${cartP.cartToken}");
                                            await cartP.addHomeProductsToCart(
                                                context,
                                                Product(
                                                    id: int.parse(element.entityId!),
                                                    name: element.name,
                                                    sku: element.sku,
                                                    price: double.parse(element.price!),
                                                    image: element.image!,
                                                    description: element.description!,
                                                    faceSubArea: int.parse(element.faceSubArea!),
                                                    avgRating: "0"));
                                          });
                                          if (tiop.lookname.value != "myselection" && tiop.lookname.value != "m16") {
                                            LooksController looksController = Get.find();
                                            int skuindex = looksController.lookModel!.items!
                                                .indexWhere((element) => element.name == tiop.lookname.value);
                                            await Provider.of<CartProvider>(context, listen: false).addToCart(context,
                                                looksController.lookModel!.items![skuindex].sku!, [], 1, tiop.lookname.value);
                                          }
                                        } catch (err) {
                                          print(err);
                                          print("cart errorr");
                                        } finally {
                                          setState(() {
                                            adding = false;
                                          });
                                        }

                                      });

                                    },
                                    backgroundColor: tiop.isChangeButtonColor.isTrue&&tiop.sku.value=="1234"?tiop.ontapColor:Colors.black,
                                    height: size.height * 0.04,
                                    child: adding == true
                                        ? Center(
                                      child: SpinKitDoubleBounce(
                                        color: Color(0xffF2CA8A),
                                        size: 30.0,
                                      ),
                                      // CircularProgressIndicator(),
                                    )
                                        : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        PngIcon(
                                          image: 'assets/icons/add_to_cart_yellow.png',
                                        ),
                                        SizedBox(width: size.width * 0.012),
                                        Text(
                                          'ADD ALL',
                                          style: Theme.of(context).textTheme.headline2!.copyWith(
                                            color: Colors.white,
                                            fontSize: size.height * 0.012,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ),
                            ],
                          )),
                      Expanded(
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () async {
                                  //print("print(tiop.bottomSheetVisible.value); ${tiop.bottomSheetVisible.value}");
                                  if (tiop.bottomSheetVisible.value) {
                                    await _controller.reverse();
                                    await tiop.pc.value.close();
                                    // tiop.toggleBottomSheetVisibility();
                                    // tiop.toggleShadesIconSelection(true);
                                  } else {
                                    // tiop.toggleBottomSheetVisibility();
                                    // tiop.toggleShadesIconSelection(false);
                                    await tiop.pc.value.open();
                                    await _controller.forward();
                                    print("print(tiop.bottomSheetVisible.value); false ${tiop.bottomSheetVisible.value}");
                                  }
                                },
                                icon: PngIcon(
                                  image: tiop.bottomSheetVisible.value
                                      ? 'assets/icons/push_down_black.png'
                                      : 'assets/icons/push_up_black.png',
                                ),
                              )))
                    ],
                  ),
                ),
              ),
              panel: Material(
                  child:
                  // Container(
                  //   width: size.width,
                  //   height: size.height * 0.06,
                  //   padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  //   decoration: BoxDecoration(
                  //     color: Colors.red
                  //   ),
                  // ),
                  Obx(() {
                    return tiop.directProduct.value
                        ? Container(
                      height: 97,
                      color: Color(0xFFF4F2F0),
                      child: Obx(
                            () {
                          ///--->> sliding panel
                          return tryOn.TryOnProduct(
                            product: tiop.received.value,
                          );
                        },
                      ),
                    )
                        : Container(
                      // 1.5 row in bottom menu sheet
                      // height: tiop.selectedProduct.value == true ? 190 : 150,
                        color: Color(0xFFF4F2F0),
                        child:BottomSheetBody(
                          tiop: tiop,
                          controller: controller,
                          selectefcontroller: selectedcontroller,
                        )
                    );
                  })
              ),
            );
          }),


///---- old bottom sheet opener
//           Obx(
//                 () => tiop.directProduct.value == false //&& tiop.centralLeftmostloading.isTrue
//                 ? Material(
//               child: Container(
//                 alignment: Alignment.center,
//                 width: size.width,
//                 height: size.height * 0.06,
//                 padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
//                 decoration: BoxDecoration(
//                   color: Color(0XFFFFFFFF),
//                 ),
//                 child: Obx(
//                       () {
//                     int count = tiop.count.value;
//
//                     // Center ADD all and blink text
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Expanded(
//                           child: count > 1
//                               ? vis
//                               ? Text(
//                             '${count > 12 ? 12 : count} RECOMMENDATIONS',
//                             style: Theme.of(context).textTheme.headline2!.copyWith(
//                               color: Colors.black,
//                               fontSize: 9,
//                               letterSpacing: 0,
//                             ),
//                           )
//                               : Container(
//                             width: 100,
//                           )
//                               : Container(
//                             width: 100,
//                           ),
//                         ),
//                         // Center ADD all and blink text
//                         Expanded(
//                             child: CapsuleButton(
//                               onPress: () async {
//                                 print("ENTER 00  ${tiop.lookname.value}");
//                                 // show loader
//                                 tiop.showLoaderDialog(context);
//                                 setState(() {
//                                   adding = true;
//                                 });
//                                 try {
//                                   tiop.lookname.value == "myselection"
//                                       ? AddToCardMySelection(context)
//                                       : tiop.lookname.value == "m16"
//                                       ? AddToCardm16(context)
//                                       : controller.ms8model!.itemData!.forEach((element) async {
//                                     CartProvider cartP = Provider.of<CartProvider>(context, listen: false);
//                                     print("CartProvider  -->> SSs ${cartP.cartToken}");
//                                     await cartP.addHomeProductsToCart(
//                                         context,
//                                         Product(
//                                             id: int.parse(element.entityId!),
//                                             name: element.name,
//                                             sku: element.sku,
//                                             price: double.parse(element.price!),
//                                             image: element.image!,
//                                             description: element.description!,
//                                             faceSubArea: int.parse(element.faceSubArea!),
//                                             avgRating: "0"));
//                                   });
//                                   if (tiop.lookname.value != "myselection" && tiop.lookname.value != "m16") {
//                                     LooksController looksController = Get.put(LooksController());
//                                     int skuindex = looksController.lookModel!.items!
//                                         .indexWhere((element) => element.name == tiop.lookname.value);
//                                     await Provider.of<CartProvider>(context, listen: false).addToCart(context,
//                                         looksController.lookModel!.items![skuindex].sku!, [], 1, tiop.lookname.value);
//                                   }
//                                 } catch (err) {
//                                   print(err);
//                                   print("cart errorr");
//                                 } finally {
//                                   setState(() {
//                                     adding = false;
//                                   });
//                                 }
//                               },
//                               height: size.height * 0.04,
//                               child: adding == true
//                                   ? Center(
//                                 child: SpinKitDoubleBounce(
//                                   color: Color(0xffF2CA8A),
//                                   size: 30.0,
//                                 ),
//                                 // CircularProgressIndicator(),
//                               )
//                                   : Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   PngIcon(
//                                     image: 'assets/icons/add_to_cart_yellow.png',
//                                   ),
//                                   SizedBox(width: size.width * 0.012),
//                                   Text(
//                                     'ADD ALL',
//                                     style: Theme.of(context).textTheme.headline2!.copyWith(
//                                       color: Colors.white,
//                                       fontSize: size.height * 0.012,
//                                       letterSpacing: 0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )),
//                         Expanded(
//                             child: Container(
//                                 alignment: Alignment.centerRight,
//                                 child: IconButton(
//                                   onPressed: () async {
//                                     if (tiop.bottomSheetVisible.value) {
//                                       await _controller.reverse();
//                                       tiop.toggleBottomSheetVisibility();
//                                       tiop.toggleShadesIconSelection(true);
//                                     } else {
//                                       tiop.toggleBottomSheetVisibility();
//                                       tiop.toggleShadesIconSelection(false);
//                                       await _controller.forward();
//                                     }
//                                   },
//                                   icon: PngIcon(
//                                     image: tiop.bottomSheetVisible.value
//                                         ? 'assets/icons/push_down_black.png'
//                                         : 'assets/icons/push_up_black.png',
//                                   ),
//                                 )))
//                       ],
//                     );
//                   },
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
//                 ),
//               ),
//             ) : Container(),
//           ),

//Show bottom products

        ///----- old bottom sheet
        //   Obx(() {
        //     return tiop.directProduct.value
        //         ? Container(
        //             height: 97,
        //             color: Color(0xFFF4F2F0),
        //             child: Obx(
        //               () {
        //                 return tryOn.TryOnProduct(
        //                   product: tiop.received.value,
        //                 );
        //               },
        //             ),
        //           )
        //         : SizeTransition(
        //             sizeFactor: _animation,
        //             axis: Axis.vertical,
        //             axisAlignment: -1,
        //             child: Container(
        //                 // 1.5 row in bottom menu sheet
        //                 height: tiop.selectedProduct.value == true ? 190 : 150,
        //                 color: Color(0xFFF4F2F0),
        //                 child: BottomSheetBody(
        //                   tiop: tiop,
        //                   controller: controller,
        //                   selectefcontroller: selectedcontroller,
        //                 )),
        //           );
        //   })
        ],
      ),
    );
  }

  AddToCardMySelection(BuildContext context) {
    int length=0;
    // selectedcontroller
    //     .selectedProduct!.items?.forEach((element) async{
    selectedcontroller
        .tryMySelectionList.forEach((element) async{
      print("ENTER 11 $length");
      CartProvider cartP =
      Provider.of<CartProvider>(context,
          listen: false);
      print("ENTER 33 $length");
      print(
          "CartProvider  -->> SSs ${cartP.cartToken}");
      await cartP.addHomeProductsToCart(
          context,
          Product(
              id: int.parse(element
                  .product!.entityId!),
              name: element.product!.name,
              sku: element.product!.sku,
              price: double.parse(
                  element.product!.price!),
              image: element.product.image??"",
              description: element
                  .product!.description!,
              // faceSubArea: int.parse(element
              //     .product!.faceSubArea!),
              //Add 2 because it reseves int but come string to solve exception error pass 2
              faceSubArea: 2,
              avgRating: element
                  .product!.avgrating!
          )
      );
      print("ENTER 22 $length  total ${selectedcontroller.selectedProduct!.items!.length}");
      length++;
      if(length==selectedcontroller.tryMySelectionList.length)
      {
        Navigator.pop(context);
        // product snack bar
        Get.showSnackbar(
          GetSnackBar(
            message: 'Added all products $length',
            duration: Duration(seconds: 2),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: "https://sofiqe.com/media/catalog/product/cache/983707a945d60f44d700277fbf98de57\$image",
                // fit: BoxFit.cover,
                placeholder: (context, _) => Image.asset(
                  'assets/images/sofiqe-font-logo-2.png',
                ),
                errorWidget: (context, url, error) {
                  return ProductErrorImage(
                    width: 400,
                    height: 400,
                  );
                },
              ),
            ),
          ),
        );
      }
    });
  }

  AddToCardm16(BuildContext contex) {
    //tiop.showLoaderDialog(context);
    int length = 0;
    tiop.centralcolorleftmostselected.forEach((element) async {
      CartProvider cartP = Provider.of<CartProvider>(contex, listen: false);
      print("CartProvider  -->> SSs ${cartP.cartToken}");
      // tiop.showLoaderDialog(context);

      // Add all product from make over screen
      await cartP.addHomeProductsToCartForOverlay(
          contex,
          NewProductModel(
              id: int.parse(element.entityId!),
              name: element.name,
              sku: element.sku,
              price: double.parse(element.price!),
              image: element.image??"",
              description: element.description!,
              faceSubArea: element.faceSubArea!,
              avgRating: "0"));

      length++;
      if (length == tiop.centralcolorleftmostselected.length) {
        Navigator.pop(contex);
        Get.showSnackbar(
          GetSnackBar(
            message: 'Added all products $length',
            duration: Duration(seconds: 2),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: "https://sofiqe.com/media/catalog/product/cache/983707a945d60f44d700277fbf98de57\$image",
                // fit: BoxFit.cover,
                placeholder: (context, _) => Image.asset(
                  'assets/images/sofiqe-font-logo-2.png',
                ),
                errorWidget: (context, url, error) {
                  return ProductErrorImage(
                    width: 400,
                    height: 400,
                  );
                },
              ),
            ),
          ),
        );
      }
    });
  }

  Tryitonscan(Ms8Controller controller, BuildContext context) {
    print("Tryitonscan 11");
    print("controller.ms8model!.itemData ${controller.ms8model!.itemData!.length}");
    int length = 0;
    controller.ms8model!.itemData!.forEach((element) async {
      CartProvider cartP = Provider.of<CartProvider>(context, listen: false);
      print("CartProvider  -->> SSs ${cartP.cartToken}");
      await cartP.addHomeProductsToCart(
          context,
          Product(
              id: int.parse(element.entityId!),
              name: element.name,
              sku: element.sku,
              price: double.parse(element.price!),
              image: element.image!,
              description: element.description!,
              faceSubArea: int.parse(element.faceSubArea!),
              avgRating: "0"));
      length++;
      if (length == controller.ms8model?.itemData!.length) {
        Navigator.pop(context);
        Get.showSnackbar(
          GetSnackBar(
            message: 'Added all products $length',
            duration: Duration(seconds: 2),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: "https://sofiqe.com/media/catalog/product/cache/983707a945d60f44d700277fbf98de57\$image",
                // fit: BoxFit.cover,
                placeholder: (context, _) => Image.asset(
                  'assets/images/sofiqe-font-logo-2.png',
                ),
                errorWidget: (context, url, error) {
                  return ProductErrorImage(
                    width: 400,
                    height: 400,
                  );
                },
              ),
            ),
          ),
        );
      }
    });
  }
}

///---------Bottom Sheet Body
class BottomSheetBody extends StatefulWidget {
  final TryItOnProvider tiop;
  final Ms8Controller controller;
  final SelectedProductController selectefcontroller;

  BottomSheetBody({Key? key, required this.tiop, required this.controller, required this.selectefcontroller})
      : super(key: key);

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  @override
  void initState() {
    widget.selectefcontroller.isreplace.value = false;
    widget.selectefcontroller.isreplace_1.value=false;
    widget.selectefcontroller.temp1=[];
    widget.selectefcontroller.value=[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("widget.tiop.lookname.value ${widget.tiop.lookname.value}");
    return Container(
      child: Column(
        children: [
          // Obx(() {
          //   return widget.tiop.lookname.value == "myselection" &&
          //           widget.tiop.selectedProduct.isTrue &&
          //           widget.tiop.centralcolor.length > 0
          //       ? BottomSheetTabs(
          //           tmo: widget.tiop,
          //         )
          //       : widget.tiop.selectedProduct.isTrue &&
          //               widget.tiop.lookname.value == "m16" &&
          //               widget.tiop.centralcolor.length > 0
          //           ? BottomSheetTabs(
          //               tmo: widget.tiop,
          //             )
          //           : Container();
          // }),

          SizedBox(
            height: Get.height* .07,
          ),


          Expanded(
              child: widget.tiop.lookname.value == "myselection"
                  ? BottomSheetItemList(
                      selectedcontroller: widget.selectefcontroller,
                      tmo: widget.tiop,
                    )
                  : widget.tiop.lookname.value == "m16"
                      ? LeftMostList(
                          controller: widget.controller,
                          tmo: widget.tiop,
                        )
                      : LookList(
                          tmo: widget.tiop,
                          controller: widget.controller,
                        )),

// =======
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(3.0),
//                             child: PngIcon(
//                               image: 'assets/icons/share/send@3x.png',
//                               padding: EdgeInsets.zero,
//                               height: 20,
//                               width: 20,
//                             ),
//                           ),
//                           Text(
//                             "Share".toUpperCase(),
//                             style: TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.black,
//                                 decoration: TextDecoration.none),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Obx(() => tiop.directProduct.value
//               ? Container()
//               : Material(
//                   child: Container(
//                     alignment: Alignment.centerRight,
//                     width: size.width,
//                     height: size.height * 0.06,
//                     padding:
//                         EdgeInsets.symmetric(horizontal: size.width * 0.02),
//                     decoration: BoxDecoration(
//                       color: Color(0xFFF4F2F0),
//                     ),
//                     child: Obx(
//                       () {
//                         return IconButton(
//                           onPressed: () async {
//                             if (tiop.received.value.sku!.isEmpty) {
//                               return;
//                             }
//                             if (tiop.bottomSheetVisible.value) {
//                               await _controller.reverse();
//                               tiop.toggleBottomSheetVisibility();
//                             } else {
//                               tiop.toggleBottomSheetVisibility();
//                               await _controller.forward();
//                             }
//                           },
//                           icon: PngIcon(
//                             image: tiop.bottomSheetVisible.value
//                                 ? 'assets/icons/push_down_black.png'
//                                 : 'assets/icons/push_up_black.png',
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 )),
//           Obx(() => tiop.directProduct.value
//               ? Container(
//                   height: size.height * 0.12,
//                   color: Color(0xFFF4F2F0),
//                   child: Obx(
//                     () {
//                       return TryOnProduct(
//                         product: tiop.received.value,
//                       );
//                     },
//                   ),
//                 )
//               : SizeTransition(
//                   sizeFactor: _animation,
//                   axis: Axis.vertical,
//                   axisAlignment: -1,
//                   child: Container(
//                     height: size.height * 0.12,
//                     color: Color(0xFFF4F2F0),
//                     child: Obx(
//                       () {
//                         print("dfb");
//                         return TryOnProduct(
//                           product: tiop.received.value,
//                         );
//                       },
//                     ),
//                   ),
//                 ))
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
        ],
      ),
    );
  }
}

///-------------------------------------

///------Recommend Color Tabs
class BottomSheetTabs extends StatelessWidget {
  final TryItOnProvider tmo;

  const BottomSheetTabs({Key? key, required this.tmo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.05,
      width: size.width,
      decoration: BoxDecoration(
          // border: Border(
          //   top: BorderSide(
          //     color: Colors.grey[300] as Color,
          //     // color: Colors.black,
          //   ),
          //   bottom: BorderSide(
          //     color: Colors.grey[300] as Color,
          //     // color: Colors.black,
          //   ),
          // ),
          ),
      child: CentralColorSelector(tmo: tmo),
    );
  }
}

class CentralColorSelector extends StatelessWidget {
  final TryItOnProvider tmo;

  CentralColorSelector({Key? key, required this.tmo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // tmo.Lookname.value == "myselection" ? tmo.getCentralColors() : null;
    return Container(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(
            () {
              tmo.isSelectColorIndex.value = 1000;
              int code = tmo.currentSelectedArea.value;
              List<Colorss> recom = [];
              tmo.centralcolor.forEach((Colorss a) {
                recom.add(a);
              });
              return recom.isNotEmpty
                  ? Row(
                      children: [
                        ...recom.map(
                          (color) {
                            return TryOnColorChoice(
                              hex: color.colourAltHEX!,
                              name: color.colourAltName!,
                              code: code,
                            );
                          },
                        ).toList(),
                      ],
                    )
                  : Container();
            }
            //  }
            ,
          )),
    );
  }
}

class TryOnColorChoice extends StatelessWidget {
  final String hex;
  final String name;
  final int code;

  TryOnColorChoice({Key? key, required this.hex, required this.name, required this.code}) : super(key: key);

  final TryItOnProvider tmo = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(onTap: () {
      print("pressss");
      print(hex);
      print(tmo.currentSelectedCentralColor);
      tmo.showSelected.value = true;
      tmo.isFirstCalling.value=true;
      tmo.currentSelectedcentralColorToggle(hex, name);
    }, child: Obx(
      () {
        return Container(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.01),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: tmo.currentSelectedCentralColor['name'] == name
                    ? Colors.black
                    // ? Color.fromRGBO(242, 202, 138, 1)
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
          ),
          child: Text(
            '$name'.toUpperCase(),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.014,
                  letterSpacing: 0,
                ),
          ),
        );
      },
    ));
  }
}

///------------------------

///-----Bottom Sheet Items
class BottomSheetItemList extends StatefulWidget {
  final TryItOnProvider tmo;
  final SelectedProductController selectedcontroller;

  BottomSheetItemList({Key? key, required this.selectedcontroller, required this.tmo}) : super(key: key);

  @override
  State<BottomSheetItemList> createState() => _BottomSheetItemListState();
}

class _BottomSheetItemListState extends State<BottomSheetItemList> {
  bool isSelectedProductLoading = true;
  SelectedProduct? selectedProduct;
  List<GlobalKey> items = [];

  @override
  void initState() {
    super.initState();
    widget.selectedcontroller.IstryMySelection.value=true;
    widget.selectedcontroller.isreplace.value = false;
    widget.selectedcontroller.isreplace_1.value=false;
    widget.selectedcontroller.temp1=[];
    widget.selectedcontroller.value=[];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.tmo.getuserfacecolor();
    });
  }

  Future scroll(int num) async {

    final context = items[num].currentContext!;
    Scrollable.ensureVisible(context);
    scrollController.animateTo( //go to top of scroll
        0,  //scroll offset to go
        duration: Duration(milliseconds: 500), //duration of scroll
        curve:Curves.fastOutSlowIn //scroll type
    );
  }
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.selectedcontroller.loadin.isTrue || widget.tmo.centralLeftmostloading.isTrue
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircularProgressIndicator(),
                SpinKitDoubleBounce(
                  color: Color(0xffF2CA8A),
                  size: 30.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please wait,\nwe are loading your previous selections",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.black,
                        fontSize: 13,
                        letterSpacing: 0,
                      ),
                  textAlign: TextAlign.center,
                )
              ],
            ))
          : SingleChildScrollView(
        controller: scrollController,
        child: widget.selectedcontroller.selectedProduct != null
            ? Obx(() {
          List<Items> temp3 = [];
          List<Items> temp1 = [];
          List<Items> temp2 = [];
          print("${widget.tmo.centralcolorleftmostselected.length}+${widget.tmo.centralLeftmostloading.isTrue}");

          widget.selectedcontroller.selectedProduct!.items!
              .forEach((ele) {
            widget.tmo.centralcolorleftmostselected
                .forEach((element) {
              print(" widget.selectedcontroller.selectedProduct!.items ${element.entityId}");
              if (element.sku == ele.product!.sku) {

                if (element.faceArea == "Eyes") {
                  temp1.addIf(!temp1.map((item) => item.product!.entityId).contains(ele.product!.entityId), ele);
                } else if (element.faceArea == "Lips") {
                  temp2.addIf(!temp2.map((item) => item.product!.entityId).contains(ele.product!.entityId), ele);
                } else if (element.faceArea == "Cheeks") {
                  temp3.addIf(!temp3.map((item) => item.product!.entityId).contains(ele.product!.entityId), ele);
                }
              }
            });
          });
          if(widget.selectedcontroller.IstryMySelection.isTrue)
          {
            widget.selectedcontroller.tryMySelectionList.value=[...temp1,...temp2,...temp3];
            widget.selectedcontroller.IstryMySelection.value=false;
          }
          if (widget.tmo.selectedFaceArea.value == "Eyes") {
            widget.selectedcontroller.temp=temp1;
          } else if (widget.tmo.selectedFaceArea.value == "Lips") {
            widget.selectedcontroller.temp = temp2;
          } else if (widget.tmo.selectedFaceArea.value ==
              "Cheeks") {
            widget.selectedcontroller.temp = temp3;
          }
          widget.selectedcontroller.temp.forEach((element) {
            final name = GlobalKey();
            items.add(name);
          });

          widget.tmo.count.value =
              temp1.length + temp2.length + temp3.length;
          return
            ObserveableProducts(
              items: items,
              scroll: scroll,
              selectedcontroller: widget.selectedcontroller,
              tmo: widget.tmo,
              scrollController: scrollController,
            );
        })
            : Center(
          child: Text(
            "No Products",
            style: TextStyle(fontSize: 18, decoration: TextDecoration.none, color: Colors.black),
          ),
        ),
      );
    });
  }
}

class ObserveableProducts extends StatelessWidget {
  final List<GlobalKey> items;
  final Function scroll;
  final TryItOnProvider tmo;
  final SelectedProductController selectedcontroller;
  final ScrollController scrollController;
  ObserveableProducts({required this.items, required this.scroll, required this.selectedcontroller, required this.tmo,required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return selectedcontroller.temp.length > 0 && selectedcontroller.selectedProduct != null
        ? Obx(() {
            print("${selectedcontroller.temp.length}  ${tmo.count.value}");
            return Column(
              children: selectedcontroller.isreplace.value
                  ? selectedcontroller.value
                      .map((item) =>
                  Container(
                            key: items[selectedcontroller.temp.indexOf(item)],
                            child: TryOnLookProduct(
                              scrll: scroll,
                              index: selectedcontroller.selectedProduct!.items!.indexOf(item),
                              index1: selectedcontroller.value.indexOf(item),
                              product: ItemData(
                                attributeSetId: item.product!.attributeSetId,
                                brand: item.product!.brand,
                                createdAt: item.product!.createdAt,
                                dealFromDate: item.product!.dealFromDate,
                                dealToDate: item.product!.dealToDate,
                                description: item.product!.description,
                                entityId: item.product!.entityId,
                                shadeColor: item.product!.shadeColor,
                                extensionAttributes: ExtensionAttributes(
                                    avgratings: item.product!.avgrating,
                                    rewardPoints: item.product!.rewardPoints,
                                    reviewCount: item.product!.reviewCount),
                                faceArea: item.faceSubArea,
                                faceColor: item.product!.faceColor,
                                faceSubArea: item.product!.faceSubArea,
                                price: item.product!.price,
                                hasOptions: item.product!.hasOptions,
                                image: item.product!.image,
                                ingredients: item.product!.ingredients,
                                sku: item.product!.sku,
                                name: item.product!.name,
                                recommendedColor: item.product!.shadeColor,
//item.product!.faceColor,
// recommendedColor: "#e0119d",
                                urlPath: item.product!.urlPath??"",
                              ),
                            ),
                          )
              )
                      .toList()
                  : selectedcontroller.isreplace_1.value?selectedcontroller.temp1
                      .map((item) =>
                          Container(
                            key: items[selectedcontroller.temp.indexOf(item)],
                            child: TryOnLookProduct(
                              scrll: scroll,
                              index: selectedcontroller.selectedProduct!.items!.indexOf(item),
                              index1: selectedcontroller.temp1.indexOf(item),
                              product: ItemData(
                                attributeSetId: item.product!.attributeSetId,
                                brand: item.product!.brand,
                                createdAt: item.product!.createdAt,
                                dealFromDate: item.product!.dealFromDate,
                                dealToDate: item.product!.dealToDate,
                                description: item.product!.description,
                                entityId: item.product!.entityId,
                                shadeColor: item.product!.shadeColor,
                                extensionAttributes: ExtensionAttributes(
                                    avgratings: item.product!.avgrating,
                                    rewardPoints: item.product!.rewardPoints,
                                    reviewCount: item.product!.reviewCount),
                                faceArea: item.faceSubArea,
                                faceColor: item.product!.faceColor,
                                faceSubArea: item.product!.faceSubArea,
                                price: item.product!.price,
                                hasOptions: item.product!.hasOptions,
                                image: item.product!.image,
                                ingredients: item.product!.ingredients,
                                sku: item.product!.sku,
                                name: item.product!.name,
                                recommendedColor: item.product!.shadeColor,
//item.product!.faceColor,
// recommendedColor: "#e0119d",
                                urlPath: item.product!.urlPath,
                              ),
                            ),
                          )
              )
                      .toList():selectedcontroller.temp
                  .map((item) =>
                  Container(
                    key: items[selectedcontroller.temp.indexOf(item)],
                    child: TryOnLookProduct(
                      scrll: scroll,
                      index: selectedcontroller.selectedProduct!.items!.indexOf(item),
                      index1: selectedcontroller.temp.indexOf(item),
                      product: ItemData(
                        attributeSetId: item.product!.attributeSetId,
                        brand: item.product!.brand,
                        createdAt: item.product!.createdAt,
                        dealFromDate: item.product!.dealFromDate,
                        dealToDate: item.product!.dealToDate,
                        description: item.product!.description,
                        entityId: item.product!.entityId,
                        shadeColor: item.product!.shadeColor,
                        extensionAttributes: ExtensionAttributes(
                            avgratings: item.product!.avgrating,
                            rewardPoints: item.product!.rewardPoints,
                            reviewCount: item.product!.reviewCount),
                        faceArea: item.faceSubArea,
                        faceColor: item.product!.faceColor,
                        faceSubArea: item.product!.faceSubArea,
                        price: item.product!.price,
                        hasOptions: item.product!.hasOptions,
                        image: item.product!.image,
                        ingredients: item.product!.ingredients,
                        sku: item.product!.sku,
                        name: item.product!.name,
                        recommendedColor: item.product!.shadeColor,
//item.product!.faceColor,
// recommendedColor: "#e0119d",
                        urlPath: item.product!.urlPath,
                      ),
                    ),
                  )
              ).toList()
            );
          })
        : Center(
            child: Text(
              "No Products",
              style: TextStyle(fontSize: 18, decoration: TextDecoration.none, color: Colors.black),
            ),
          );
  }
}

///-------------------------

///---------Look List
class LookList extends StatefulWidget {
  final TryItOnProvider tmo;

  final Ms8Controller controller;

  LookList({Key? key, required this.controller, required this.tmo}) : super(key: key);

  @override
  State<LookList> createState() => _LookListState();
}

class _LookListState extends State<LookList> {
  getdata() async {
    await widget.controller.getLookList(widget.tmo.lookname.value);
  }

  List<GlobalKey> items = [];

  @override
  void initState() {
    selectedProductController.isreplace.value = false;
    getdata();
    super.initState();
  }

  Future scroll(int num) async {
    final context = items[num].currentContext!;
    Scrollable.ensureVisible(context);
  }

  final SelectedProductController selectedProductController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.tmo.lookloading.isTrue
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Swirl Text
                // CircularProgressIndicator(),
                SpinKitDoubleBounce(
                  color: Color(0xffF2CA8A),
                  size: 30.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Please wait,\nwe are collecting your\npersonal colours",
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Colors.black,
                          fontSize: 13,
                          letterSpacing: 0,
                        ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ))
          : SingleChildScrollView(
              child: Container(child: Obx(() {
                List<ItemData>? temp = [];
                temp = widget.controller.ms8model?.itemData!
                    .where((element) => element.faceArea == widget.tmo.selectedFaceArea.value)
                    .toList();
                print("look list");
                selectedProductController.temp = temp!;
                items = [];
                temp.forEach((element) {
                  final name = GlobalKey();
                  items.add(name);
                });
                widget.tmo.count.value = widget.controller.ms8model?.itemData!.length ?? 0;

                print('===== length of temp is ${items.length} ======');

                return temp.isNotEmpty
                    ? Column(
                        children: temp.length < 1
                            ? [
                                SizedBox(
                                  height: 10,
                                ),
                                SpinKitDoubleBounce(
                                  color: Color(0xffF2CA8A),
                                  size: 30.0,
                                ),
                                // CircularProgressIndicator(),
                              ]
                            : selectedProductController.isreplace.isFalse
                                ? temp
                                    .map((item) => Container(
                                        key: items[temp!.indexOf(item)],
                                        child: TryOnLookProduct(
                                          index1: temp.indexOf(item),
                                          scrll: scroll,
                                          index: temp.indexOf(item),
                                          product: item,
                                        )))
                                    .toList()
                                : selectedProductController.value
                                    .map((item) => Container(
                                        key: items[temp!.indexOf(item)],
                                        child: TryOnLookProduct(
                                          index1: temp.indexOf(item),
                                          scrll: scroll,
                                          index: temp.indexOf(item),
                                          product: item,
                                        )))
                                    .toList())
                    : Center(
                        child: Text(
                          "No Products",
                          style: TextStyle(fontSize: 18, decoration: TextDecoration.none, color: Colors.black),
                        ),
                      );
              })),
            );
    });
  }
}

///-------------------------

class LeftMostList extends StatefulWidget {
  final TryItOnProvider tmo;

  final Ms8Controller controller;
  LeftMostList({Key? key, required this.controller, required this.tmo}) : super(key: key);

  @override
  State<LeftMostList> createState() => _LeftMostListState();
}

class _LeftMostListState extends State<LeftMostList> {
  List<GlobalKey> items = [];
  List itemList = [];

// fetching Api Data
  getData() async {
    await widget.tmo.getuserfacecolor();
  }

  @override
  void initState() {
    super.initState();
    selectedProductController.isreplace.value = false;
    getData();
    getItem();
  }

  Future scroll(int num) async {
    scrollController.animateTo( //go to top of scroll
        0,  //scroll offset to go
        duration: Duration(milliseconds: 500), //duration of scroll
        curve:Curves.fastOutSlowIn //scroll type
    );
    final context = itemList[num].currentContext!;
    Scrollable.ensureVisible(context);

  }

// fetching global key list
  getItem() async {
    itemList = await widget.tmo.items;
    if (widget.tmo.temp1.length > itemList.length) {
      widget.tmo.temp1.forEach((element) {
        final name = GlobalKey();
        itemList.add(name);
      });
    }
  }

  final SelectedProductController selectedProductController = Get.find();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(seconds: 2),
        () => Center(
              child: SpinKitDoubleBounce(
                color: Color(0xffF2CA8A),
                size: 30.0,
              ),
              // CircularProgressIndicator(),
            ));
    return Obx(() {
      List<FaceSubareaLeftmostListOfProducts> temp1 = [];
print("LEST LEST ${widget.tmo.centralcolorleftmostselected.length}");
      widget.tmo.centralcolorleftmostselected.forEach((element) {
        print(" widget. ${element.entityId}    element.faceArea${widget.tmo.selectedFaceArea.value}");
        if (element.faceArea == widget.tmo.selectedFaceArea.value) {
          print("SUBAREA ${element.entityId}");
          temp1.add(element);
        }
      });
      selectedProductController.temp = temp1;

      // temp = widget.tmo.centralcolorleftmost
      //     .where((p0) =>
      // p0.faceArea == widget.tmo.selectedFaceArea.value)
      //     .toList();
      // temp.forEach((element) {
      //   // temp1.add(element.faceSubareaLeftmostListOfProducts![0]);
      //

      //   element.faceSubareaLeftmostListOfProducts!.forEach((ele) {
      //     temp1.add(ele);
      //   });
      // });
      // print("temp");
      // temp1.forEach((element) {
      //   final name = GlobalKey();
      //   items.add(name);
      // });

      // widget.tmo.count.value = widget.tmo.centralcolorleftmostselected.length;

      return widget.tmo.centralLeftmostloading.isTrue && temp1.isEmpty
          ? Center(
              child: SpinKitDoubleBounce(
                color: Color(0xffF2CA8A),
                size: 30.0,
              ),
              // CircularProgressIndicator(),
            )
          : SingleChildScrollView(
        controller: scrollController,
              child: Container(
                child: temp1.isNotEmpty
                    ? Column(
                    children: selectedProductController.isreplace.value
                        ? selectedProductController.value
                        .map((item) =>
                        showProducts(item,selectedProductController.value.indexOf(item))
                    )
                        .toList()
                        : selectedProductController.isreplace_1.value?selectedProductController.temp1
                        .map((item) =>
                        showProducts(item,selectedProductController.temp1.indexOf(item))
                    )
                        .toList():selectedProductController.temp
                        .map((item) =>
                        showProducts(item,selectedProductController.temp.indexOf(item))
                    ).toList()
                      )
                    : Center(
                        child: Text(
                          "No Products",
                          style: TextStyle(fontSize: 20, decoration: TextDecoration.none, color: Colors.black),
                        ),
                      ),
              ),
            );
    });
  }

 Widget showProducts(item,index) {
   return GestureDetector(
      onTap: () {
      },
      child: Container(
        //key: itemList[temp1.indexOf(item)],
          child: TryOnLookProduct(
            index1: index,
            scrll: scroll,
            index: index,
            product: ItemData(
                attributeSetId: item.attributeSetId,
                sku: item.sku,
                urlPath: item.urlPath,
                name: item.name,
                faceArea: item.faceSubAreaName,
                keyName: item.faceSubAreaName,
                image: item.image,
                recommendedColor: item.faceColor,
                extensionAttributes:
                ExtensionAttributes(rewardPoints: "0", productUrl: "", avgratings: ""),
                description: item.description,
                price: item.price,
                entityId: item.entityId,
                faceColor: item.faceColor,
                shadeColor: item.shadeColor,
                faceSubArea: item.faceSubArea),
          )),
    );

  }
}