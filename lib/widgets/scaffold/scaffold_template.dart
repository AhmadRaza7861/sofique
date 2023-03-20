// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/Ms1/ms1_profile.dart';
import 'package:sofiqe/screens/catalog_screen.dart';
import 'package:sofiqe/screens/home_screen.dart';
import 'package:sofiqe/screens/make_over_screen.dart';
import 'package:sofiqe/widgets/scaffold/custom_bottom_navigation_bar.dart';
import '../../controller/controllers.dart';
import '../../controller/fabController.dart';
import '../../provider/account_provider.dart';
import '../../provider/catalog_provider.dart';
import '../../provider/make_over_provider.dart';
import '../../screens/MS6/reviews.dart';
import '../../screens/Ms3/looks_screen.dart';
import '../../screens/try_it_on_screen.dart';
import '../../utils/AppLayout.dart';
import 'custom_fab.dart';

class ScaffoldTemplate extends StatefulWidget {
  final Widget child;
  final int index;
  ScaffoldTemplate({Key? key, required this.child, this.index = 0}) : super(key: key);

  @override
  _ScaffoldTemplateState createState() => _ScaffoldTemplateState();
}

class _ScaffoldTemplateState extends State<ScaffoldTemplate> {
  late int index = widget.index;
  PageController pageController = PageController();
  List<Widget> body = [
    HomeScreen(),
    CatalogScreen(),
    MakeOverScreen(),
    Ms1Profile(),
//   MySofiqe(),
  ];

  final PageProvider pp = Get.find();
  final TryItOnProvider tiop = Get.find();
  final CatalogProvider catp = Get.find();
  final MakeOverProvider mop = Get.find();
  final FABController fabController = Get.find();
  // final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    fabController.showFab.value = true;
    pp.onTapCallback = onTap;
  }

  void onTap(int index) async {
    setState(() {
      this.index = index;
    });
    pageController.animateToPage(index, duration: Duration(microseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: [SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          // alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          // fit: StackFit.loose,
          children: [
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              allowImplicitScrolling: false,
              children: body,
            ),
            // WidgetsBinding.instance.window.viewInsets.bottom > 0.0 || mop.screen.value  == 4 ? const SizedBox() :

            Obx(() {
              return  MediaQuery.of(context).viewInsets.bottom > 0.0 || fabController.showFab.value == false
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.only(
                        // bottom: AppLayout.getHeight(23),
                        top: AppLayout.getHeight(10),
                        right: AppLayout.getHeight(30),
                      ),
                      // padding: EdgeInsets.only(
                      //   // bottom: AppLayout.getHeight(23),
                      //   top: AppLayout.getHeight(200),
                      // ),
                      child: FabCircularMenu(
                          key: fabController.fabKey,
                          onDisplayChange: (bool val) {
                            print('==== is open $val  =====');
                          },
                          alignment: Alignment.bottomCenter,
                          fabMargin: EdgeInsets.zero,
                          fabColor: Colors.transparent,
                          fabSize: AppLayout.getHeight(60),
                          ringColor: Color(0xffF6DFED),
                          // ringColor: Colors.pinkAccent.withOpacity(.2),
                          ringWidth: AppLayout.getWidth(160),
                          ringDiameter: AppLayout.getHeight(380),
                          fabElevation: 0,
                          fabOpenColor: Colors.transparent,
                          fabChild: Image.asset(
                            'assets/images/new-menu-circle-01.png',
                            // height: ,
                          ),

                          // Center(
                          //   child: SvgPicture.asset('assets/images/my-beauty-bottom.svg',
                          //     // height: 100,
                          //     //   width: 100,
                          //
                          //   ),
                          // ),
                          // Column(
                          //   mainAxisSize: MainAxisSize.min,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text('My\nBeauty',
                          //     textAlign: TextAlign.center,
                          //       style: Theme.of(context).textTheme.headline2!.copyWith(
                          //         color: Colors.white,
                          //         fontSize:  10,
                          //         letterSpacing: 0,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: AppLayout.getHeight(90), top: AppLayout.getHeight(25)),
                              child: GestureDetector(
                                onTap: () {
                                  fabController.fabKey.currentState!.close();
                                  // makeOverProvider.screen.value = 6;
                                  // makeOverProvider.colorAna.value = true;
                                  tiop.lookname.value = "myselection";
                                  //  tiop.Lookname.value="myselection";
                                  // tiop.received.value = Product.fromDefaultMap(responseBody);
                                  tiop.page.value = 2;
                                  tiop.lookProduct.value = true;
                                  tiop.directProduct.value = false;
                                  // Navigator.push(context,MaterialPageRoute(builder: (builder)=>TryItOnScreen()));
                                  Get.to(
                                    () => TryItOnScreen(),
                                    transition: Transition.downToUp,
                                    duration: const Duration(milliseconds: 1500),
                                  );
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //----Icon
                                    SvgPicture.asset(
                                      'assets/images/menu-eye.svg',
                                      // width: 40,
                                      // color: Color(0xffF6DFED),
                                    ),
                                    SizedBox(
                                      height: AppLayout.getHeight(3),
                                    ),
                                    Text(
                                      'Selections',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline3!.copyWith(
                                            color: Color(0xffEB7AC1),
                                            fontSize: AppLayout.getHeight(11),
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                right: AppLayout.getHeight(45),
                                bottom: AppLayout.getHeight(40),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  fabController.fabKey.currentState!.close();
                                  !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
                                      ? index == 3
                                          ? profileController.screen.value = 1
                                          : Get.showSnackbar(
                                              GetSnackBar(
                                                message: 'Please sign in to see your reviews/wishlists',
                                                duration: Duration(
                                                  seconds: 2,
                                                ),
                                              ),
                                            )
                                      : Get.to(
                                          () => ReviewsMS6(),
                                          transition: Transition.upToDown,
                                          duration: const Duration(milliseconds: 1200),
                                        );
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //----Icon
                                    Image.asset(
                                      'assets/images/menu-reviews.png',
                                      // height: 40,
                                      width: AppLayout.getWidth(26),
                                    ),
                                    SizedBox(
                                      height: AppLayout.getHeight(3),
                                    ),
                                    Text(
                                      'Reviews\nWishlist',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline3!.copyWith(
                                            height: AppLayout.getHeight(1.1),
                                            color: Color(0xffEB7AC1),
                                            fontSize: AppLayout.getHeight(11),
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: AppLayout.getHeight(30), bottom: AppLayout.getHeight(40)),
                              child: GestureDetector(
                                onTap: () {
                                  fabController.fabKey.currentState!.close();
                                  Get.to(
                                    () => TryItOnScreen(),
                                    transition: Transition.fadeIn,
                                    duration: const Duration(milliseconds: 600),
                                  );
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //----Icon
                                    SvgPicture.asset(
                                      'assets/images/menu-mobile.svg',
                                      width: AppLayout.getWidth(20),
                                    ),
                                    SizedBox(
                                      height: AppLayout.getHeight(4),
                                    ),
                                    Text(
                                      'Try On',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline3!.copyWith(
                                            color: Color(0xffEB7AC1),
                                            fontSize: AppLayout.getHeight(11),
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: AppLayout.getHeight(70), top: AppLayout.getHeight(15)),
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.vibrate();
                                  SystemSound.play(SystemSoundType.click);
                                  !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
                                      ? index == 3
                                          ? profileController.screen.value = 2
                                          : Get.showSnackbar(
                                              GetSnackBar(
                                                message: 'Please sign in to see your Looks',
                                                duration: Duration(
                                                  seconds: 2,
                                                ),
                                              ),
                                            )
                                      : Get.to(
                                          () => LooksScreen(),
                                          transition: Transition.leftToRightWithFade,
                                          duration: const Duration(milliseconds: 1200),
                                        );

                                  // if (fabKey.currentState!.isOpen) {
                                  fabController.fabKey.currentState!.close();
                                  // } else {
                                  //   fabKey.currentState.open();
                                  // }
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //----Icon
                                    // Icon(
                                    //   Icons.face,
                                    //   color: Colors.pink,
                                    //   size: 34,
                                    // ),
                                    Image.asset(
                                      'assets/images/women-menu.png',
                                      width: AppLayout.getWidth(50),
                                      height: AppLayout.getHeight(40),
                                    ),
                                    Text(
                                      'Looks',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline3!.copyWith(
                                            color: Color(0xffEB7AC1),
                                            fontSize: AppLayout.getHeight(11),
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // IconButton(icon: Icon(Icons.home), onPressed: () {
                            //   print('Home');
                            // }),
                            // IconButton(icon: Icon(Icons.home), onPressed: () {
                            //   print('Home');
                            // }),
                            // IconButton(icon: Icon(Icons.home), onPressed: () {
                            //   print('Home');
                            // }),
                            // IconButton(icon: Icon(Icons.favorite), onPressed: () {
                            //   print('Favorite');
                            // })
                          ]),
                    );
            }),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: index,
          onTap: onTap,
        ),

        // floatingActionButton: WidgetsBinding.instance.window.viewInsets.bottom > 0.0 || index > 1 ?  const SizedBox() : Container(
        //   margin: EdgeInsets.only(
        //     bottom: AppLayout.getHeight(23),
        //     right: AppLayout.getHeight(30),
        //   ),
        //   child: FabCircularMenu(
        //     // onDisplayChange: ,
        //     alignment: Alignment.bottomCenter,
        //     fabColor: Colors.transparent,
        //     fabSize: AppLayout.getHeight(60),
        //     ringColor: Colors.pinkAccent.withOpacity(.2),
        //     ringWidth: AppLayout.getWidth(160),
        //     ringDiameter: AppLayout.getHeight(340),
        //     fabElevation: 0,
        //     fabOpenColor: Colors.transparent,
        //     fabChild: Center(
        //       child: SvgPicture.asset('assets/images/my-beauty-bottom.svg',
        //       // height: 100,
        //       //   width: 100,
        //
        //       ),
        //     ),
        //     // Column(
        //     //   mainAxisSize: MainAxisSize.min,
        //     //   mainAxisAlignment: MainAxisAlignment.center,
        //     //   children: [
        //     //     Text('My\nBeauty',
        //     //     textAlign: TextAlign.center,
        //     //       style: Theme.of(context).textTheme.headline2!.copyWith(
        //     //         color: Colors.white,
        //     //         fontSize:  10,
        //     //         letterSpacing: 0,
        //     //       ),
        //     //     ),
        //     //   ],
        //     // ),
        //       children: <Widget>[
        //
        //         Container(
        //           margin: EdgeInsets.only(
        //             right: AppLayout.getHeight(65),
        //             top: AppLayout.getHeight(45)
        //           ),
        //           child: GestureDetector(
        //             onTap: (){
        //               // makeOverProvider.screen.value = 6;
        //               // makeOverProvider.colorAna.value = true;
        //               tiop.lookname.value="myselection";
        //               //  tiop.Lookname.value="myselection";
        //               // tiop.received.value = Product.fromDefaultMap(responseBody);
        //               tiop.page.value = 2;
        //               tiop.lookProduct.value = true;
        //               tiop.directProduct.value = false;
        //               // Navigator.push(context,MaterialPageRoute(builder: (builder)=>TryItOnScreen()));
        //               Get.to(() => TryItOnScreen(),
        //                 transition: Transition.downToUp,
        //                 duration: const Duration(milliseconds: 1500),
        //               );
        //             },
        //             behavior: HitTestBehavior.opaque,
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 //----Icon
        //                 SvgPicture.asset(
        //                     'assets/images/menu-eye.svg',
        //                   // width: 40,
        //                   // color: Color(0xffF6DFED),
        //                 ),
        //                 SizedBox(
        //                   height: AppLayout.getHeight(3),
        //                 ),
        //                 Text('Selections',
        //                   textAlign: TextAlign.center,
        //                   style: Theme.of(context).textTheme.headline3!.copyWith(
        //                     color: Color(0xffEB7AC1),
        //                     fontSize:  AppLayout.getHeight(11),
        //                     letterSpacing: 0,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         Container(
        //           margin: EdgeInsets.only(
        //             right: AppLayout.getHeight(25),
        //             bottom: AppLayout.getHeight(10),
        //           ),
        //           child: GestureDetector(
        //             onTap: (){
        //               !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
        //                   ? profileController.screen.value = 1
        //                   : Get.to(() => ReviewsMS6(),
        //                 transition: Transition.upToDown,
        //                 duration: const Duration(milliseconds: 1200),
        //               );
        //             },
        //             behavior: HitTestBehavior.opaque,
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 //----Icon
        //                Image.asset('assets/images/menu-reviews.png',
        //                 // height: 40,
        //                  width: AppLayout.getWidth(26),
        //                ),
        //                 SizedBox(
        //                   height: AppLayout.getHeight(3),
        //                 ),
        //                 Text('Reviews\nWishlist',
        //                   textAlign: TextAlign.center,
        //                   style: Theme.of(context).textTheme.headline3!.copyWith(
        //                     height: AppLayout.getHeight(1.1),
        //                     color: Color(0xffEB7AC1),
        //                     fontSize:  AppLayout.getHeight(11),
        //                     letterSpacing: 0,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //
        //         Container(
        //           margin: EdgeInsets.only(
        //               left: AppLayout.getHeight(20),
        //             bottom: AppLayout.getHeight(10)
        //           ),
        //           child: GestureDetector(
        //             onTap: (){
        //               Get.to(() => TryItOnScreen(),
        //                 transition: Transition.fadeIn,
        //                 duration: const Duration(milliseconds: 600),
        //               );
        //             },
        //             behavior: HitTestBehavior.opaque,
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 //----Icon
        //                 SvgPicture.asset(
        //                     'assets/images/menu-mobile.svg',
        //                   width: AppLayout.getWidth(20),
        //                 ),
        //                 SizedBox(
        //                   height: AppLayout.getHeight(4),
        //                 ),
        //                 Text('Try On',
        //                   textAlign: TextAlign.center,
        //                   style: Theme.of(context).textTheme.headline3!.copyWith(
        //                     color: Color(0xffEB7AC1),
        //                     fontSize:  AppLayout.getHeight(11),
        //                     letterSpacing: 0,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //
        //         Container(
        //           margin: EdgeInsets.only(
        //               left: AppLayout.getHeight(50),
        //               top: AppLayout.getHeight(30)
        //           ),
        //           child: GestureDetector(
        //             onTap: (){
        //               HapticFeedback.vibrate();
        //               SystemSound.play(SystemSoundType.alert);
        //
        //               !Provider.of<AccountProvider>(context, listen: false).isLoggedIn
        //                   ? profileController.screen.value = 2
        //                   : Get.to(() => LooksScreen(),
        //                 transition: Transition.leftToRightWithFade,
        //                 duration: const Duration(milliseconds: 1200),
        //               );
        //             },
        //             behavior: HitTestBehavior.opaque,
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 //----Icon
        //                 // Icon(
        //                 //   Icons.face,
        //                 //   color: Colors.pink,
        //                 //   size: 34,
        //                 // ),
        //                 Image.asset(
        //                  'assets/images/women-menu.png',
        //                   width: AppLayout.getWidth(50),
        //                   height: AppLayout.getHeight(40),
        //                 ),
        //                 Text('Looks',
        //                   textAlign: TextAlign.center,
        //                   style: Theme.of(context).textTheme.headline3!.copyWith(
        //                     color: Color(0xffEB7AC1),
        //                     fontSize:  AppLayout.getHeight(11),
        //                     letterSpacing: 0,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //
        //
        //         // IconButton(icon: Icon(Icons.home), onPressed: () {
        //         //   print('Home');
        //         // }),
        //         // IconButton(icon: Icon(Icons.home), onPressed: () {
        //         //   print('Home');
        //         // }),
        //         // IconButton(icon: Icon(Icons.home), onPressed: () {
        //         //   print('Home');
        //         // }),
        //         // IconButton(icon: Icon(Icons.favorite), onPressed: () {
        //         //   print('Favorite');
        //         // })
        //       ]
        //   ),
        // )
      ),
    );
  }
}