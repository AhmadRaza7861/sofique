// 3rd party packages
// ignore_for_file: deprecated_member_use

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/screens/try_it_on_screen.dart';
import 'package:sofiqe/widgets/makeover/make_over_gallery.dart';
import 'package:sofiqe/widgets/makeover/make_over_login_prompt.dart';
import 'package:sofiqe/widgets/makeover/total_make_over/make_over_try_on.dart';
// Custom packages
import 'package:sofiqe/widgets/selfie_camera.dart';

class MakeOverScreen extends StatefulWidget {
  MakeOverScreen({Key? key}) : super(key: key);

  @override
  State<MakeOverScreen> createState() => _MakeOverScreenState();
}

class _MakeOverScreenState extends State<MakeOverScreen> {
  @override
  void initState() {
    super.initState();
print("DIRECT PRODUCT 11  ${tiop.directProduct.value}");
    // ignore: unnecessary_statements;
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    makeOverProvider.colorAna.value == true ? true : false;
    makeOverProvider.questions.value = questionsController.makeover;
    makeOverProvider.update();
    print("DIRECT PRODUCT 22  ${tiop.directProduct.value}");
  }
  final TryItOnProvider tiop = Get.find();

  @override
  @override
  Widget build(BuildContext context) {

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: [SystemUiOverlay.top]);


    return  Obx(() {
      print("makeOverProvider.screen.value ${makeOverProvider.screen.value}");
      if (makeOverProvider.colorAna.value == true) {
        var widgetToBuild;
        if (makeOverProvider.screen.value == 1) {
          widgetToBuild = skinAnalysis(widgetToBuild);
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

                    tiop.lookname.value="m16";
                    // tiop.received.value = Product.fromDefaultMap(responseBody);
                    tiop.page.value = 2;
                    tiop.lookProduct.value = true;
                    tiop.directProduct.value = false;
                    //  Navigator.push(context,MaterialPageRoute(builder: (builder)=>TryItOnScreen()));
                    // return TotalMakeOver(cameras: snapshot.data);
                    return TryItOnScreen();
                  } else {
                    return Container();
                  }
                },
              ),
            );
          }
        } else if (makeOverProvider.screen.value == 5) {
          widgetToBuild = colourAnalysis(widgetToBuild);
        } else if (makeOverProvider.screen.value == 6) {
          widgetToBuild = MakeOverTryOn();
          // Container(
          //   child: FutureBuilder(
          //     future: availableCameras(),
          //     builder: (BuildContext _,
          //         AsyncSnapshot<List<CameraDescription>> snapshot) {
          //       if (snapshot.hasData) {
          //         return MakeOverTryOn(cameras: snapshot.data);
          //       } else {
          //         return Container();
          //       }
          //     },
          //   ),
          // );
          makeOverProvider.colorAna.value = false;
          makeOverProvider.screen.value = 1;
        } else {
          widgetToBuild = Container();
        }
        return widgetToBuild;
      } else
        return  Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/makeovebg.png'),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.053,
              ),
              Text(
                'sofiqe',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              Spacer(),
              Text(
                'Please select',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              buttonPadding(),
              ElevatedButton(
                onPressed: () {
                  makeOverProvider.colorAna.value = true;

                  setState(() {});
                  //Get.to(() => MakeOverGallery());
                },
                child: Container(
                    height: 50,
                    width: Get.width * 0.7,
                    alignment: Alignment.center,
                    child: Text('Skin and colour analysis')),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
              ),
              buttonPadding(),
              ElevatedButton(
                onPressed: () {
                  print("this button");
                  makeOverProvider.colorAna.value = true;
                  makeOverProvider.currentQuestion.value = 6;
                  setState(() {

                  });
                  // Get.to(() => MakeOverGallery());
                },
                child: Container(
                    height: 50,
                    width: Get.width * 0.7,
                    alignment: Alignment.center,
                    child: Text('Colour analysis')),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
              ),
              buttonPadding(),
              Obx(() => ElevatedButton(
                onPressed: makeOverProvider.tryitOn.value
                    ? () {
                  // makeOverProvider.screen.value = 6;
                  // makeOverProvider.colorAna.value = true;
                  tiop.lookname.value="myselection";
                  //  tiop.Lookname.value="myselection";
                  // tiop.received.value = Product.fromDefaultMap(responseBody);
                  tiop.page.value = 2;
                  tiop.lookProduct.value = true;
                  tiop.directProduct.value = false;
                  Navigator.push(context,MaterialPageRoute(builder: (builder)=>TryItOnScreen()));
                }
                    : () {},
                child: Container(
                    height: 50,
                    width: Get.width * 0.7,
                    alignment: Alignment.center,
                    child: Text(
                      'Try My Selections',
                      style: TextStyle(color: Colors.black),
                    )),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: makeOverProvider.tryitOn.value
                      ? Colors.white
                      : Colors.grey[700],
                  onPrimary: makeOverProvider.tryitOn.value
                      ? Colors.black
                      : Colors.white,
                  ),
                )
              ),
              SizedBox(
                height: Get.height * 0.053,
              ),
            ],
          ),
        );

    });

  }

  skinAnalysis(widgetToBuild) {
    widgetToBuild = Container(
      child: FutureBuilder(
        future: availableCameras(),
        builder:
            (BuildContext _, AsyncSnapshot<List<CameraDescription>> snapshot) {
          if (snapshot.hasData) {
            return SelfieCamera(cameras: snapshot.data);
          } else {
            return Container();
          }
        },
      ),
    );
    return widgetToBuild;
  }

  colourAnalysis(widgetToBuild) {
    widgetToBuild = Container(
      child: FutureBuilder(
        future: availableCameras(),
        builder:
            (BuildContext _, AsyncSnapshot<List<CameraDescription>> snapshot) {
          if (snapshot.hasData) {
            return SelfieCamera(cameras: snapshot.data);
          } else {
            return Container();
          }
        },
      ),
    );
    return widgetToBuild;
  }

  SizedBox buttonPadding() => SizedBox(
        height: Get.height * 0.023,
      );
}