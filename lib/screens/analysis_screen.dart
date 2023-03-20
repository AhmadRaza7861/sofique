// 3rd party packages
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/try_it_on_screen.dart';
import 'package:sofiqe/widgets/makeover/make_over_gallery.dart';
import 'package:sofiqe/widgets/makeover/make_over_login_prompt.dart';
// Custom packages
import 'package:sofiqe/widgets/selfie_camera.dart';

class AnalysisScreen extends StatelessWidget {
  AnalysisScreen({Key? key}) : super(key: key);
  final TryItOnProvider tiop = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var widgetToBuild;
        if (makeOverProvider.screen.value == 1) {
          widgetToBuild = Container(
            child: FutureBuilder(
              future: availableCameras(),
              builder: (BuildContext _,
                  AsyncSnapshot<List<CameraDescription>> snapshot) {
                if (snapshot.hasData) {
                  return SelfieCamera(cameras: snapshot.data);
                } else {
                  return Container();
                }
              },
            ),
          );
        } else if (makeOverProvider.screen.value == 2) {
          widgetToBuild = MakeOverGallery();
        } else if (makeOverProvider.screen.value == 3) {
          widgetToBuild = MakeOverLoginPrompt();
        } else if (makeOverProvider.screen.value == 4) {
          if (!Provider.of<AccountProvider>(context, listen: false)
              .isLoggedIn) {
            makeOverProvider.screen.value = 3;
            widgetToBuild = MakeOverLoginPrompt();
          } else {
            widgetToBuild = Container(
              child: FutureBuilder(
                future: availableCameras(),
                builder: (BuildContext _,
                    AsyncSnapshot<List<CameraDescription>> snapshot) {
                  if (snapshot.hasData) {
                         tiop.lookname.value="myselection".toString();
                                                  // tiop.received.value = Product.fromDefaultMap(responseBody);
                    tiop.page.value = 2;
                    tiop.lookProduct.value = true;
                    tiop.directProduct.value = false;

                    return TryItOnScreen();
                    // return TotalMakeOver(cameras: snapshot.data);
                  } else {
                    return Container();
                  }
                },
              ),
            );
          }
        } else {
          widgetToBuild = Container();
        }
        return widgetToBuild;
      },
    );
  }

  SizedBox buttonPadding() => SizedBox(
        height: Get.height * 0.023,
      );
}
