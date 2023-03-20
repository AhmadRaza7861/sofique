// ignore_for_file: deprecated_member_use

import 'dart:io';

// 3rd party packages
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/provider/total_make_over_provider.dart';
import 'package:sofiqe/widgets/makeover/blur.dart';
// Custom packages
import 'package:sofiqe/widgets/makeover/total_make_over/make_over_try_on.dart';

class TotalMakeOver extends StatefulWidget {
  final List<CameraDescription>? cameras;

  TotalMakeOver({this.cameras});

  @override
  _TotalMakeOverState createState() => _TotalMakeOverState();
}

class _TotalMakeOverState extends State<TotalMakeOver> {
  late CameraController controller;
  final TotalMakeOverProvider tmo = Get.put(TotalMakeOverProvider());
  final MakeOverProvider mop = Get.find();

  @override
  void initState() {
    super.initState();
    //this is temporary code for testing
    //now start

    controller = CameraController(widget.cameras![1], ResolutionPreset.veryHigh, enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    //till end
    tmo.shareCallback = () {
      captureImage('makeover_image');
    };
  }

  @override
  void dispose() {
    try {
      controller.dispose();
      super.dispose();
    } catch (e) {}
  }

  bool notWarned = true;
  bool backToStart = false;

  void captureImage(String imageName) async {
    XFile image = await controller.takePicture();
    var dir = (await getExternalStorageDirectory());
    File file = File(join(dir!.path, '$imageName.jpg'));
    if (await file.exists()) {
      await file.delete();
    }
    await image.saveTo(file.path);
    await Share.shareFiles([File(file.path).path]);
    print(image.path);
  }

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    if (!controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      // appBar: AppBar(
      //       backgroundColor: Colors.black,
      //       elevation: 0.0,
      //       leading: InkWell(
      //           onTap: () => Get.back(),
      //           child: Icon(
      //             Icons.close,
      //             size: 30,
      //           )),

      //       ),
      body: Stack(
        children: [
          Positioned(
            top: -size.height * 0.087,
            child: Container(
              height: size.height,
              width: size.width,
              child: OverflowBox(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Container(
                    height: size.height - size.height * 0.167,
                    width: size.width,
                    child: LayoutBuilder(builder: (context, snapshot) {
                      return AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: CameraPreview(
                          controller,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () {
              if (tmo.colorsAreReady.value) {
                return MakeOverTryOn();
              } else {
                return Blur();
              }
            },
          ),
          Obx(
            () {
              if (tmo.colorsAreReady.value) {
                return Container();
              }
              return notWarned
                  ? Container()
                  : Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.03),
                        constraints: BoxConstraints(
                          maxWidth: size.width * 0.6,
                          maxHeight: size.height * 0.2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFF2CA8A)),
                          color: Colors.black,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                'sofiqe',
                                style: Theme.of(context).textTheme.headline1!.copyWith(
                                      color: Color(0xFFF2CA8A),
                                      fontSize: size.height * 0.04,
                                      height: 1,
                                    ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Please wait while we complete your makeover',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline2!.copyWith(
                                      color: Colors.white,
                                      fontSize: size.height * 0.02,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
          notWarned ? Blur() : Container(),
          Align(
            alignment: Alignment.center,
            child: notWarned
                ? Warning(
                    forward: () {
                      notWarned = false;
                      setState(() {});
                      Future.delayed(const Duration(milliseconds: 500), () {
                        makeOverProvider.screen.value = 6;
                      });
                      // makeOverProvider.tryitOn.value = true;
                      // pp.goToPage(Pages.MAKEOVER);
                      // makeOverProvider.colorAna.value = true;

                      // Navigator.pop(context);
                      // makeOverProvider.tryitOn.value = true;
                      /// profileController.screen.value = 0;

                      //Get.to(() => MakeOverTryOn());
                      // makeOverProvider.tryitOn.value = true;
                    },
                    reset: () async {
                      await controller.dispose();
                      notWarned = false;
                      backToStart = true;
                      mop.reset();
                      mop.screen.value = 1;
                    },
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}

class Warning extends StatelessWidget {
  final void Function() forward;
  final void Function() reset;

  const Warning({Key? key, required this.forward, required this.reset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.04),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFF2CA8A),
        ),
        color: Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'sofiqe',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Color(0xFFF2CA8A),
                          fontSize: size.height * 0.04,
                          height: 1,
                        ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      forward();
                    },
                    child: Icon(
                      Icons.close,
                      color: Color(0xFFF2CA8A),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            'Our analysis is made based on a combination of light around you when you made your selfie, your answers and if you have any skin condition that can affect the colour analysis.\n\n\nWe use AI to make the recommendations, but the human is always superior to make colour matches. Please use it as a recommendation only.\nThe final say is yours.\n\nThanks',
            // textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.white,
                  fontSize: size.height * 0.02,
                ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  reset();
                },
                child: Text(
                  'NEW ANALYSIS',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Color(0xFFF2CA8A),
                        fontSize: size.height * 0.015,
                      ),
                ),
              ),
              TextButton(
                onPressed: () {
                  forward();
                },
                child: Text(
                  'CONTINUE',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Color(0xFFF2CA8A),
                        fontSize: size.height * 0.015,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
