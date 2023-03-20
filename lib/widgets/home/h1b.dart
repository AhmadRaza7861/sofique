import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/catalog_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/widgets/animated_round_button.dart';

class H1B extends StatelessWidget {
  H1B({Key? key}) : super(key: key);

  final PageProvider pp = Get.find();
  final CatalogProvider catp = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(
          vertical: size.width * 0.03, horizontal: size.width * 0.03),
      child: GestureDetector(
        onTap: () {
          catp.setFaceArea(FaceArea.ALL);
          pp.goToPage(Pages.TRYITON);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/home_h1b_background.png',
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedRoundButton(
                inActiveBackgroundColor: Colors.transparent,
                activeBackgroundColor: Colors.black,
                activeChild: SvgPicture.asset('assets/svg/eye_primary.svg'),
                inActiveChild: SvgPicture.asset('assets/svg/eye_primary.svg',
                    color: Colors.white),
                activeBorderColor: Colors.transparent,
                inActiveBorderColor: Colors.white30,
                width: size.width * 0.12,
                onTap: () {
                  catp.setFaceArea(FaceArea.EYES);
                  pp.goToPage(Pages.TRYITON);
                },
              ),
              SizedBox(height: size.height * 0.02),
              AnimatedRoundButton(
                inActiveBackgroundColor: Colors.transparent,
                activeBackgroundColor: Colors.black,
                activeChild: SvgPicture.asset('assets/svg/mouth_white.svg',
                    color: Color(0xFFF2CA8A)),
                inActiveChild: SvgPicture.asset('assets/svg/mouth_white.svg',
                    color: Colors.white),
                activeBorderColor: Colors.transparent,
                inActiveBorderColor: Colors.white30,
                width: size.width * 0.12,
                onTap: () {
                  catp.setFaceArea(FaceArea.LIPS);
                  pp.goToPage(Pages.TRYITON);
                },
              ),
              SizedBox(height: size.height * 0.02),
              AnimatedRoundButton(
                inActiveBackgroundColor: Colors.transparent,
                activeBackgroundColor: Colors.black,
                activeChild: SvgPicture.asset('assets/svg/cheeks_white.svg',
                    color: Color(0xFFF2CA8A)),
                inActiveChild: SvgPicture.asset('assets/svg/cheeks_white.svg',
                    color: Colors.white),
                activeBorderColor: Colors.transparent,
                inActiveBorderColor: Colors.white30,
                width: size.width * 0.12,
                onTap: () {
                  catp.setFaceArea(FaceArea.CHEEKS);
                  pp.goToPage(Pages.TRYITON);
                },
              ),
              SizedBox(height: size.height * 0.08),
              Center(
                child: Text(
                  'PRODUCTS',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.white,
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Center(
                child: Text(
                  'FOR',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.white,
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Center(
                child: Text(
                  'MAKING',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.white,
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(height: size.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
