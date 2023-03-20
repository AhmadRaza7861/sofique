import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/msProfileController.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/catalog_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/total_make_over_provider.dart';
import 'package:sofiqe/utils/constants/route_names.dart';
import 'package:sofiqe/widgets/home/home_page.dart';
// Custom packages
import 'package:sofiqe/widgets/png_icon.dart';

import '../provider/cart_provider.dart';
import '../provider/try_it_on_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageProvider pp = Get.find();

  final CatalogProvider catp = Get.find();

  final MsProfileController profileController = Get.put(MsProfileController());

  final TotalMakeOverProvider tm = Get.put(TotalMakeOverProvider());
  final TryItOnProvider TIOP=Get.find();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    profileController.getUserQuestionsInformations();
// <<<<<<< HEAD
//     var cartItems = Provider.of<CartProvider>(context).cart!=null?Provider.of<CartProvider>(context).cart!.length:0;
// =======
    var cartItems = Provider.of<CartProvider>(context).getCartLength();
    var cartTotalQty = Provider.of<CartProvider>(context).getTotalQty();
    // print("carttotalQty HOME SCREEN ::$cartTotalQty");
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: Center(
            child: GestureDetector(
              onTap: () {
                pp.goToPage(Pages.TRYITON);
                catp.unhideSeachBar();
                print(Provider.of<AccountProvider>(context, listen: false).userToken);
              },
              child: Container(
                height: AppBar().preferredSize.height * 0.7,
                width: AppBar().preferredSize.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppBar().preferredSize.height * 0.7)),
                  border: Border.all(color: Colors.white12, width: 1),
                ),
                child: PngIcon(
                  image: 'assets/icons/search_white.png',
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'sofiqe',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white, fontSize: size.height * 0.035, letterSpacing: 0.6),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
          ],
        ),
        actions: [
          Container(
            height: AppBar().preferredSize.height,
            width: AppBar().preferredSize.height * 1,
            child:
            Center(
              child: GestureDetector(
                onTap: () {
                  TIOP.isChangeButtonColor.value=true;
                  TIOP.playSound();

                  Future.delayed(Duration(milliseconds: 10)).then((value)
                  {
                    TIOP.isChangeButtonColor.value=false;
                    Navigator.pushNamed(context, RouteNames.cartScreen);
                  });
                },
                child: Obx(()=>
                   Container(
                    height: AppBar().preferredSize.height * 0.7,
                    width: AppBar().preferredSize.height * 0.7,
                    decoration: BoxDecoration(
                      color:TIOP.isChangeButtonColor.isTrue?TIOP.ontapColor:Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppBar().preferredSize.height * 0.7)),
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        PngIcon(
                          image: 'assets/images/Path_6.png',
                        ),
                        cartItems == 0
                            ? SizedBox()
                            : Container(
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                padding: EdgeInsets.all(5),
                                child: Text(cartTotalQty.toString()))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: HomePage(),
    );
  }
}