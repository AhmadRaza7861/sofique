import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/make_over_provider.dart';

// Utils
import 'package:sofiqe/utils/constants/app_colors.dart';

// Custom packages
import 'package:sofiqe/widgets/circle_icon.dart';

class MakeOverTabs extends StatelessWidget {
  final MakeOverProvider mop = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Obx(
              () => _MakeOverTab(
                index: 0,
                callback: (var newVal) {
                  mop.changeTab(newVal);
                },
                label: 'Analysis',
                currentIndex: mop.tab,
                icon: CircleIcon(
                  icon: Text(
                    '?',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 11,
                          letterSpacing: 0.68,
                          color:
                              // ignore: unrelated_type_equality_checks
                              mop.tab == 0 ? Colors.black : Color(0xFFC9C1B3),
                        ),
                  ),
                  size: 18,
                  backgroundColor: mop.tab.value == 0
                      ? AppColors.primaryColor
                      : AppColors.transparent,
                ),
              ),
            ),
          ),
          Container(height: 50, width:0.70, color: AppColors.secondaryColor),
          Expanded(
            child: Obx(
              () => _MakeOverTab(
                index: 1,
                callback: (var newVal) {
                  mop.changeTab(newVal);
                },
                label: 'Face Scan',
                currentIndex: mop.tab,
                icon: CircleIcon(
                  icon: Image.asset(
                    mop.tab.value == 1
                        ? 'assets/icons/question_tabs_facescan_active.png'
                        : 'assets/icons/question_tabs_facescan.png',
                    scale: 2.2,
                  ),
                  size: 18,
                  backgroundColor: mop.tab.value == 1
                      ? AppColors.primaryColor
                      : AppColors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MakeOverTab extends StatelessWidget {
  final Widget icon;
  final String label;
  final index;
  final Function callback;
  final currentIndex;
  _MakeOverTab(
      {required this.icon,
      required this.label,
      required this.index,
      required this.callback,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback(index);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top:  BorderSide(color: AppColors.secondaryColor, width: 0.70),
              bottom: BorderSide(color: AppColors.secondaryColor, width: 0.70)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentIndex == index
                      ? AppColors.primaryColor
                      : Color(0xFFC9C1B3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
