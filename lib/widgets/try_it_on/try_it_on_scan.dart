// ignore_for_file: deprecated_member_use, await_only_futures

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/model/product_model.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/widgets/animated_round_button.dart';
import 'package:sofiqe/widgets/back_camera.dart';
import 'package:sofiqe/widgets/face_area_selector.dart';

import '../../model/ms8Model.dart';
import '../../provider/account_provider.dart';
import '../../provider/catalog_provider.dart';
import '../../screens/general_account_screen.dart';
import '../capsule_button.dart';
import '../custom_form_field.dart';

class TryItOnScan extends StatelessWidget {
  TryItOnScan({Key? key}) : super(key: key);

  final TryItOnProvider tiop = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => tiop.scan.value == 0
          ? FutureBuilder(
              future: availableCameras(),
              builder: (BuildContext c,
                  AsyncSnapshot<List<CameraDescription>> snapshot) {
                if (snapshot.hasData) {
                  CameraController controller = CameraController(
                      snapshot.data![0], ResolutionPreset.veryHigh,
                      enableAudio: false);
                  return Stack(
                    children: [
                      BackCamera(
                        controller: controller,
                      ),
                      ScanAssist(),
                      TryItOnCameraOverlay(controller)
                    ],
                  );
                } else {
                  return Container();
                }
              },
            )
          : ProductColorScanAssist()),
    );
  }
}

class ScanAssist extends StatelessWidget {
  ScanAssist({Key? key}) : super(key: key);

  final TryItOnProvider tiop = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int scan = tiop.scan.value;
      if (scan == 0) {
        return ProductLabelScanAssist();
      } else {
        return Container(
            // color: Colors.yellow,
            );
      }
    });
  }
}

class ProductLabelScanAssist extends StatefulWidget {
  ProductLabelScanAssist({Key? key}) : super(key: key);

  @override
  _ProductLabelScanAssistState createState() => _ProductLabelScanAssistState();
}

class _ProductLabelScanAssistState extends State<ProductLabelScanAssist> {
  final TryItOnProvider tiop = Get.find();

  showDialogFunction(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        builder: (context) {
          // Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop(true);
          // });
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              content: Container(
                  width: size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * 0.18,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0xFF000000)),
                  child: Column(children: [
                    Text(
                      'sofiqe',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Color(0xFFF2CA8A),
                          fontSize: 25,
                          letterSpacing: 2.5),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Thanks',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color(0xFFF2CA8A),
                          fontSize: 15,
                          letterSpacing: 1.5),
                    ),
                    SizedBox(height: 13),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Please select what part of the face this makeup belongs to in the below menu.',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Color(0xFFF2CA8A),
                            fontSize: 13,
                            letterSpacing: 1.2),
                      ),
                    )
                  ])));
        },
        context: context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialogFunction(Get.context!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.5,
            child: Obx(
              () {
                if (tiop.scan.value == 0) {
                  return Text(
                    'AIM THE BOX TO THE PRODUCT LABEL TEXT YOU WANT TO TRY ON',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Color(0xFFCC3232),
                          fontSize: size.height * 0.018,
                          letterSpacing: 0,
                        ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          SizedBox(height: size.height * 0.01),
          DottedBorder(
            strokeWidth: 2,
            color: Color(0xFFCC3232),
            dashPattern: [3],
            child: Container(
              height: size.width * 0.6,
              width: size.width * 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductColorScanAssist extends StatefulWidget {
  ProductColorScanAssist({Key? key}) : super(key: key);

  @override
  _ProductColorScanAssistState createState() => _ProductColorScanAssistState();
}

class _ProductColorScanAssistState extends State<ProductColorScanAssist> {
  // UnityWidgetController? _unityWidgetController;

  TryItOnProvider tiop = Get.find();
  final PageProvider pp = Get.find();
  var showLogin = false.obs;
  final ItemData? product = ItemData();

  performScanResult(BuildContext context) async {
    tiop.brandNameController.clear();
    tiop.productLabelController.clear();
    print(
        "DATAA ${Provider.of<AccountProvider>(context, listen: false).isLoggedIn}");
    if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
      // tiop.page.value = 2;
      // tiop.directProduct.value = false;
      tiop.received.value = Product(
          id: 159,
          name: "Armani Neo Nude Fusion Powder (Various Shades",
          sku: "202204200001641",
          price: 00,
          image:
              'https://sofiqe.com/media/catalog/product/t/m/tmp11918857-1194886584100226_145.jpg',
          description:
              "Achieve a smooth, flawless makeup look with Armani Neo Nude Fusion Powder; a weightless finishing powder that?",
          faceSubArea: 10,
          avgRating: '0');
      tiop.page.value = 2;
      tiop.directProduct.value = true;
      tiop.lookProduct.value = false;
      tiop.currentSelectedProducturl.value =
          'https://sofiqe.com/armani-neo-nude-fusion-powder-various-shades.html';
      tiop.currentSelectedProductname.value =
          'Armani Neo Nude Fusion Powder (Various Shades';
      pp.goToPage(Pages.MAKEOVER);

      await tiop.getScanResults(context);
      await tiop.getproductwarning(product!.sku!);
    } else {
      showLogin.value = true;
    }
  }

  showDialogThanks() {
    Size size = MediaQuery.of(Get.context!).size;
    showDialog(
        builder: (context) {
          Future.delayed(Duration(seconds: 3), () async {
            Navigator.of(context).pop(true);
            await performScanResult(context);
          });
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              content: Container(
                  width: size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * 0.18,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0xFF000000)),
                  child: Column(children: [
                    Text(
                      'sofiqe',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Color(0xFFF2CA8A),
                          fontSize: 25,
                          letterSpacing: 2.5),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Thanks',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color(0xFFF2CA8A),
                          fontSize: 15,
                          letterSpacing: 1.5),
                    ),
                    SizedBox(height: 13),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Please direct the camera to your face to visualise the makeup on your face.',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Color(0xFFF2CA8A),
                            fontSize: 13,
                            letterSpacing: 1.2),
                      ),
                    )
                  ])));
        },
        context: Get.context!);
  }

  @override
  void dispose() {
    super.dispose();
    // if (_unityWidgetController != null) {
    //   _unityWidgetController!.dispose();
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() => showLogin.value
            ? GeneralAccountScreen(
                message: 'Wow, that is a cool product!',
                prompt:
                    'To see how beautiful you will look, sign in or become a free Sofiqe member',
                onSuccess: () async {
                  tiop.page.value = 2;
                  tiop.directProduct.value = false;
                  pp.goToPage(Pages.MAKEOVER);
                  await tiop.getScanResults(context);
                },
              )
            : FutureBuilder(
                future: availableCameras(),
                builder: (BuildContext c,
                    AsyncSnapshot<List<CameraDescription>> snapshot) {
                  if (snapshot.hasData) {
                    CameraController controller = CameraController(
                        snapshot.data![0], ResolutionPreset.veryHigh,
                        enableAudio: false);
                    return Stack(
                      children: [
                        BackCamera(
                          controller: controller,
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: size.width,
                                height: size.height * 0.6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width * 0.5,
                                      child: Text(
                                        'AIM THE CROSS TO THE PRODUCT COLOUR YOU WANT TO TRY ON',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                              color: Color(0xFFCC3232),
                                              fontSize: size.height * 0.018,
                                              letterSpacing: 0,
                                            ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    Container(
                                      height: size.height * 0.3,
                                      width: size.width * 0.5,
                                      child: Center(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            DottedLine(
                                              dashColor: Colors.red,
                                              lineThickness: 1.5,
                                            ),
                                            DottedLine(
                                              direction: Axis.vertical,
                                              dashColor: Colors.red,
                                              lineThickness: 1.5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            ScanController(
                              capture: () async {
                                // ignore: todo
                                //TODO set here product photo
                                //await unityCaptureFacePhoto();

                                showDialogThanks();
                              },
                            )
                          ],
                        ),
                        // ScanAssist(),
                        // TryItOnCameraOverlay(controller)
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              )

        // Stack(
        //         children: [
        //           UnityWidget(
        //             onUnityCreated: onUnityCreated,
        //             onUnityMessage: onUnityColorReceived,
        //             onUnitySceneLoaded: onUnitySceneLoaded,
        //             fullscreen: false,
        //           ),
        //           Column(
        //             children: [
        //               Expanded(
        //                 child: Container(
        //                   width: size.width,
        //                   height: size.height * 0.6,
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Container(
        //                         width: size.width * 0.5,
        //                         child: Text(
        //                           'AIM THE CROSS TO THE PRODUCT COLOUR YOU WANT TO TRY ON',
        //                           textAlign: TextAlign.center,
        //                           style: Theme.of(context)
        //                               .textTheme
        //                               .headline2!
        //                               .copyWith(
        //                                 color: Color(0xFFCC3232),
        //                                 fontSize: size.height * 0.018,
        //                                 letterSpacing: 0,
        //                               ),
        //                         ),
        //                       ),
        //                       SizedBox(height: size.height * 0.01),
        //                       Container(
        //                         height: size.height * 0.3,
        //                         width: size.width * 0.5,
        //                         child: Center(
        //                           child: Stack(
        //                             alignment: Alignment.center,
        //                             children: [
        //                               DottedLine(
        //                                 dashColor: Colors.red,
        //                                 lineThickness: 1.5,
        //                               ),
        //                               DottedLine(
        //                                 direction: Axis.vertical,
        //                                 dashColor: Colors.red,
        //                                 lineThickness: 1.5,
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               ScanController(
        //                 capture: () async {
        //                   // ignore: todo
        //
        //                   //await unityCaptureFacePhoto();
        //
        //                   showDialogThanks();
        //                 },
        //               )
        //             ],
        //           ),
        //         ],
        //       ),

        );
  }

  // onUnityCreated(controller2) async {
  //   this._unityWidgetController = controller2;
  //   await this._unityWidgetController!.pause();
  //   await this._unityWidgetController!.resume();
  //   await unityChangeScene();

  // }

  onUnityColorReceived(col) {
    print(col.toString());
    showDialogThanks();
  }

  // onUnitySceneLoaded(SceneLoaded? sceneInfo) async {
  //   await this._unityWidgetController!.pause();
  //   await this._unityWidgetController!.resume();
  // }

  // unityCaptureFacePhoto() async {
  //   await this._unityWidgetController!.postMessage(
  //         'Solution',
  //         'OnCaptureClick',
  //         "capture",
  //       );
  // }

  // unityCaptureProductPhoto() async {
  //   await this._unityWidgetController!.postMessage(
  //         'RawImage',
  //         'OnCaptureClick',
  //         "capture",
  //       );
  // }

  // unityChangeScene() async {
  //   var data = await this._unityWidgetController!.postMessage(
  //         'Solution',
  //         'OnNextClick',
  //         "next",
  //       );
  // }
}

class TryItOnCameraOverlay extends StatefulWidget {
  final CameraController camera;

  TryItOnCameraOverlay(this.camera, {Key? key}) : super(key: key);

  @override
  _TryItOnCameraOverlayState createState() => _TryItOnCameraOverlayState();
}

class _TryItOnCameraOverlayState extends State<TryItOnCameraOverlay> {
  final TryItOnProvider tiop = Get.find();
  final PageProvider pp = Get.find();

  @override
  void dispose() {
    super.dispose();
    widget.camera.dispose();
  }

  showDialogProductDetailsFunction(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    tiop.dialogShowing.value = true;
    showDialog(
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              content: Container(
                  width: size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * 0.4 + 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0xFF000000)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'sofiqe',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: Color(0xFFF2CA8A),
                                    fontSize: 25,
                                    letterSpacing: 2.5),
                          ),
                        ),
                        SizedBox(height: 12),
                        Center(
                          child: Text(
                            'Thanks',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Color(0xFFF2CA8A),
                                    fontSize: 15,
                                    letterSpacing: 1.5),
                          ),
                        ),
                        SizedBox(height: 13),
                        editTextBox(context, 'Please add Brand name:',
                            tiop.brandNameController, tiop.brandName),
                        SizedBox(height: 20),
                        editTextBox(context, 'Please type product label:',
                            tiop.productLabelController, tiop.produceLabel),
                        SizedBox(height: 29),
                        Center(
                          child: CapsuleButton(
                            backgroundColor: Color(0xFFF2CA8A),
                            height: size.height * 0.068,
                            width: size.width * 0.7,
                            onPress: () async {
                              if (tiop.brandName.value.isEmpty) {
                                Get.showSnackbar(GetSnackBar(
                                  message: 'Please enter Brand Name',
                                  duration: Duration(seconds: 2),
                                ));
                                return;
                              }

                              if (tiop.produceLabel.value.isEmpty) {
                                Get.showSnackbar(GetSnackBar(
                                  message: 'Please enter Product Label',
                                  duration: Duration(seconds: 2),
                                ));
                                return;
                              }

                              tiop.dialogShowing.value = false;
                              Get.back();
                              tiop.nextScan();
                            },
                            child: Text(
                              'Next >',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    color: Colors.black,
                                    fontSize: size.width * 0.034,
                                    letterSpacing: 0,
                                  ),
                            ),
                          ),
                        )
                      ]))),
        );
      },
      context: context,
      barrierDismissible: false,
    );
  }

  Widget editTextBox(BuildContext context, String hintName,
      TextEditingController textEditingController, RxString test) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          hintName,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Color(0xFFF2CA8A), fontSize: 12, letterSpacing: 1.2),
        ),
        CustomFormField(
          label: hintName,
          controller: textEditingController,
          backgroundColor: Colors.white,
          height: 35,
          width: MediaQuery.of(context).size.width * .8,
          space: 0,
          onChange: (String value) {
            test.value = value;
          },
        )
      ]),
    );
  }

  Future<bool> captureImage(String imageName) async {
    try {
      XFile image = await widget.camera.takePicture();
      var dir = (await getExternalStorageDirectory());
      File file = File(join(dir!.path, '$imageName.jpg'));
      if (await file.exists()) {
        await file.delete();
      }
      await image.saveTo(file.path);
      return true;
    } catch (e) {
      await Get.showSnackbar(
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
    bool cameraShouldWait = false;

    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(
                vertical: size.height * 0.04, horizontal: size.width * 0.04),
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.04, horizontal: size.width * 0.04),
            width: size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () {
                    String selectedFaceArea = tiop.selectedFaceArea.value;
                    if (selectedFaceArea.isEmpty) {
                      return Container();
                    }

                    final CatalogProvider catp = Get.find();
                    List<String> faceSubArea = [];
                    if (selectedFaceArea.toLowerCase() == "cheeks") {
                      faceSubArea = catp.categoryFilter.value.childrenData!
                          .firstWhere((element) =>
                              element.name!.toLowerCase() == "complexion" ||
                              element.name!.toLowerCase() ==
                                  selectedFaceArea.toLowerCase())
                          .childrenData!
                          .map((e) => e.name!)
                          .toList();
                    } else {
                      faceSubArea = catp.categoryFilter.value.childrenData!
                          .firstWhere((element) =>
                              element.name!.toLowerCase() ==
                              selectedFaceArea.toLowerCase())
                          .childrenData!
                          .map((e) => e.name!)
                          .toList();
                    }

                    Alignment alignment = Alignment.center;
                    switch (selectedFaceArea) {
                      case 'eyes':
                        alignment = Alignment.centerLeft;
                        break;
                      case 'lips':
                        alignment = Alignment.center;

                        break;
                      case 'cheeks':
                        alignment = Alignment.centerRight;

                        break;
                    }
                    int count = 0;
                    if (tiop.faceSubAreaOptionsVisible.value) {
                      return Container(
                          width: size.width * 0.5,
                          alignment: alignment,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              double topLeft = 0;
                              double topRight = 0;
                              double bottomLeft = 0;
                              double bottomRight = 0;
                              if (count == 0) {
                                topLeft = 10;
                                topRight = 10;
                              }
                              if (count == faceSubArea.length - 1) {
                                bottomLeft = 10;
                                bottomRight = 10;
                              }
                              return GestureDetector(
                                onTap: () {
                                  tiop.selectedFaceSubArea.value =
                                      '${faceSubArea[index]}';
                                  tiop.hideFaceSubAreaOptions();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(topLeft),
                                    topRight: Radius.circular(topRight),
                                    bottomLeft: Radius.circular(bottomLeft),
                                    bottomRight: Radius.circular(bottomRight),
                                  ),
                                  child: Container(
                                    width: size.width * 0.3,
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.01),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: count++ == 0
                                                ? Colors.transparent
                                                : Colors.black),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      '${faceSubArea[index].toUpperCase()}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            color: Colors.black,
                                            fontSize: size.height * 0.014,
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            physics: ScrollPhysics(),
                            itemCount: faceSubArea.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                          ));
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(height: size.height * 0.01),
                CapsuleSelectorContainer(),
              ],
            ),
          ),
        ),
        ScanController(
          capture: () async {
            if (tiop.selectedFaceSubArea.value.isEmpty) {
              setState(() {
                tiop.selectedFaceArea.value = 'eyes';
              });
              tiop.showFaceSubAreaOptions();
              // Get.showSnackbar(GetSnackBar(
              //   message: 'Select a area where the makeup is applied on before proceeding',
              //   duration: Duration(seconds: 2),
              // ));
              return;
            }

            if (!cameraShouldWait) {
              cameraShouldWait = true;
              bool success =
                  await captureImage(tiop.capturedFileName[tiop.scan.value]);
              if (success) {
                showDialogProductDetailsFunction(context);
              }
              cameraShouldWait = false;
            } else {
              print('Wait for previous Image to be processed');
            }
          },
        ),
      ],
    );
  }
}

class CapsuleSelectorContainer extends StatefulWidget {
  const CapsuleSelectorContainer({Key? key}) : super(key: key);

  @override
  _CapsuleSelectorContainerState createState() =>
      _CapsuleSelectorContainerState();
}

class _CapsuleSelectorContainerState extends State<CapsuleSelectorContainer>
    with SingleTickerProviderStateMixin {
  TryItOnProvider tiop = Get.find();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.045, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ))
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

  @override
  void initState() {
    super.initState();
    tiop.faceAreaErrorController = _controller;
  }

  @override
  void dispose() {
    tiop.faceAreaErrorController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (tiop.scan.value != 0) {
          return Container();
        }
        return SlideTransition(
          position: _offsetAnimation,
          child: CapsuleSelector(
            onChange: (num) {
              tiop.showFaceSubAreaOptions();
              switch (num) {
                case 0:
                  tiop.selectedFaceArea.value = 'eyes';
                  break;
                case 1:
                  tiop.selectedFaceArea.value = 'lips';
                  break;
                case 2:
                  tiop.selectedFaceArea.value = 'cheeks';
                  break;
              }
            },
            radius: 50,
            options: <CapsuleOption>[
              CapsuleOption(
                selectedChild: ActiveOption(
                    svgImage: 'assets/svg/eye_primary.svg', name: 'FOR EYES'),
                unselectedChild: InactiveOption(
                    svgImage: 'assets/svg/eye_primary.svg', name: 'FOR EYES'),
                value: 0,
              ),
              CapsuleOption(
                selectedChild: ActiveOption(
                    svgImage: 'assets/svg/mouth_white.svg', name: 'FOR LIPS'),
                unselectedChild: InactiveOption(
                    svgImage: 'assets/svg/mouth_white.svg', name: 'FOR LIPS'),
                value: 1,
              ),
              CapsuleOption(
                selectedChild: ActiveOption(
                    svgImage: 'assets/svg/cheeks_white.svg',
                    name: 'FOR CHEEKS'),
                unselectedChild: InactiveOption(
                    svgImage: 'assets/svg/cheeks_white.svg',
                    name: 'FOR CHEEKS'),
                value: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ActiveOption extends StatelessWidget {
  final String svgImage;
  final String name;

  const ActiveOption({
    Key? key,
    required this.svgImage,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      height: size.height * 0.06,
      width: size.width * 0.2,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            '$svgImage',
            color: Color(0xFFF2CA8A),
          ),
          Text(
            '$name',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.white,
                  fontSize: size.height * 0.012,
                  letterSpacing: 0,
                ),
          ),
        ],
      ),
    );
  }
}

class InactiveOption extends StatelessWidget {
  final String svgImage;
  final String name;

  const InactiveOption({
    Key? key,
    required this.svgImage,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      height: size.height * 0.06,
      width: size.width * 0.2,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            '$svgImage',
            color: Colors.black,
          ),
          Text(
            '$name',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.012,
                  letterSpacing: 0,
                ),
          ),
        ],
      ),
    );
  }
}

class ScanController extends StatelessWidget {
  final void Function() capture;

  const ScanController({
    Key? key,
    required this.capture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TryItOnProvider tiop = Get.find();
    Size size = MediaQuery.of(context).size;
    return Obx(() => tiop.dialogShowing.value
        ? SizedBox()
        : Container(
            height: size.height * 0.15,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: AnimatedRoundButton(
                    activeBackgroundColor: Colors.black,
                    activeBorderColor: Colors.black,
                    activeChild: SvgPicture.asset(
                        'assets/svg/camera_icon_yellow.svg',
                        color: Colors.white),
                    inActiveBackgroundColor: Colors.black,
                    inActiveBorderColor: Colors.black,
                    inActiveChild:
                        SvgPicture.asset('assets/svg/camera_icon_yellow.svg'),
                    onTap: capture,
                    width: size.width * 0.18,
                  ),
                ),
              ],
            ),
          ));
  }
}
