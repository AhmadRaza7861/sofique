import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/controller/nav_controller.dart';
// Utils
import 'package:sofiqe/utils/constants/app_colors.dart';
// Custom packages
import 'package:sofiqe/widgets/png_icon.dart';
import '../../controller/fabController.dart';
import '../../provider/catalog_provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({Key? key, required this.currentIndex, required this.onTap})  : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  bool a = false;
  // final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  @override
  void initState() {
    Get.put(NavController());
    super.initState();
  }

  final CatalogProvider catp = Get.find();
  final FABController fabController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(
      // hide nav bar for make over flow
      // visible for all other screen
      builder: (value) => value.navbar
          ? SizedBox()
          : Stack(
        alignment: Alignment.topCenter,
        children: [
          BottomNavigationBar(
            currentIndex: widget.currentIndex,
            onTap: widget.onTap,
            /* (int newIndex) {
              switch (newIndex) {
                case 0:
                  Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
                  break;
                case 1:
                  break;
                case 2:
                  Navigator.pushReplacementNamed(context, RouteNames.catalogScreen);
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, RouteNames.makeOverScreen);
                  break;
                case 4:
                  break;
              }
              // setState(() {
              //   _currentIndex = newIndex;
              // });
         },*/
            selectedFontSize: 12,
            selectedItemColor: AppColors.navigationBarSelectedColor,
            unselectedItemColor: AppColors.navigationBarUnselectedColor,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: PngIcon(
                    image:
                    'assets/icons/bottom-navigation-bar-home-selected.png'),
                icon: PngIcon(
                    image: 'assets/icons/bottom-navigation-bar-home.png'),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                activeIcon: PngIcon(
                    image:
                    'assets/icons/bottom-navigation-bar-shop-selected.png'),
                icon: PngIcon(
                    image: 'assets/icons/bottom-navigation-bar-shop.png'),
                label: 'SHOP',
              ),
              BottomNavigationBarItem(
                activeIcon: PngIcon(
                    image:
                    'assets/icons/bottom-navigation-bar-makeover-selected.png'),
                icon: PngIcon(
                    image: 'assets/icons/bottom-navigation-bar-makeover.png'),
                label: 'MAKEOVER',
              ),
              BottomNavigationBarItem(
                activeIcon: PngIcon(
                    image:
                    'assets/icons/bottom-navigation-bar-mysofiqe-selected.png'),
                icon: PngIcon(
                    image: 'assets/icons/bottom-navigation-bar-mysofiqe.png'),
                label: 'MYSOFIQE',
              ),
            ],
          ),


          WidgetsBinding.instance.window.viewInsets.bottom > 0.0 || fabController.showFab.value  == false  ? const SizedBox()  :   InkWell(
            onTap: (){
                if (fabController.fabKey.currentState!.isOpen) {
                  fabController.fabKey.currentState?.close();
                } else {
                  log('===  Else One is hitting  ====');
                  fabController.fabKey.currentState?.open();
                }
              },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 2
              ),
              child: Image.asset('assets/images/new-menu-circle-02.png',
                width: 58,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class Nav extends StatelessWidget {
//   const Nav({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<NavController>(builder: (_) {
//       return Container()
//     });
//   }
// }