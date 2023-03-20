import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/widgets/capsule_button.dart';

class EmptyBagPage extends StatelessWidget {
  final String? emptyBagButtonText;
  EmptyBagPage({Key? key, this.emptyBagButtonText}) : super(key: key);
  final PageProvider pp = Get.find();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Transform.translate(
            offset: Offset(0, MediaQuery.of(context).size.height * 0.02),
            child: Text(
              'No way, your shopping bag is empty!',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    letterSpacing: 0.6,
                  ),
            ),
          ),
          Image.asset(
            'assets/images/empty_bag_background.png',
            height: MediaQuery.of(context).size.height * 0.55,
          ),
          CapsuleButton(
            backgroundColor: Colors.black,
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.7,
            onPress: () {
              profileController.screen.value = 0;
              Get.back();
              pp.goToPage(Pages.TRYITON);

              // Navigator.of(context).pop();
            },
            child: Text(
              emptyBagButtonText != null
                  ? emptyBagButtonText as String
                  : 'GO SHOPPING',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFFF2CA8A),
                    fontSize: 16,
                    letterSpacing: 1.4,
                  ),
            ),
          ),
          SizedBox(
            height: 55,
          )
        ],
      ),
    );
  }
}

class CustomEmptyBagPage extends StatelessWidget {
  final String emptyBagButtonText;
  final VoidCallback ontap;
  final String title;
  const CustomEmptyBagPage(
      {Key? key,
      required this.emptyBagButtonText,
      required this.ontap,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Transform.translate(
          //   offset: Offset(0, MediaQuery.of(context).size.height * 0.04),
          //   child:
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    letterSpacing: 0.6,
                  ),
            ),
          ),
          //   ),
          Image.asset(
            'assets/images/empty_bag_background.png',
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: CapsuleButton(
              height: MediaQuery.of(context).size.height * 0.065,
              width: MediaQuery.of(context).size.width * 0.65,
              onPress: ontap,
              backgroundColor: Color(0xFFF2CA8A),
              child: Text(
                emptyBagButtonText,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                      letterSpacing: 1.4,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
