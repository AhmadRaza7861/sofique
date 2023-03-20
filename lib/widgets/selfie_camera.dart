import 'dart:io';

// 3rd party packages
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/screens/MS8/ingredients_screen.dart';
import 'package:sofiqe/screens/make_over_eye.dart';
import 'package:sofiqe/screens/make_over_hair.dart';
import 'package:sofiqe/widgets/makeover/camera_overlay.dart';
// Custom packages
import 'package:sofiqe/widgets/makeover/make_over_overlay.dart';

class SelfieCamera extends StatefulWidget {
  final List<CameraDescription>? cameras;
  SelfieCamera({this.cameras});

  @override
  _SelfieCameraState createState() => _SelfieCameraState();
}

class _SelfieCameraState extends State<SelfieCamera> {
  late CameraController controller;
  late Map<String, dynamic> _cameraProperties = {
    'min-zoom-level': 1,
    'max-zoom-level': 10,
  };

  final MakeOverProvider makeOverProvider = Get.find<MakeOverProvider>();

  double _currentZoomLevel = 1;
  final MakeOverProvider mop = Get.find();
  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras![1], ResolutionPreset.veryHigh,
        enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _loadCameraProperties();
      controller.setZoomLevel(_currentZoomLevel);
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Obx(() {
      if (makeOverProvider.currentQuestion.value == 4 &&
          (makeOverProvider.underDocCare.value == false ||
              makeOverProvider.fromMed.value == true)) {
        print("ENTER ENTER ENTERE");
        return IngredientsList();
      }
      // ignore: unrelated_type_equality_checks
      else if (makeOverProvider.currentQuestion == 10) {
        print("ENTER ENTER ENTERE1111");
        return MokeOverEye();
      }
      // ignore: unrelated_type_equality_checks
      else if (makeOverProvider.currentQuestion == 11) {
        print("ENTER ENTER ENTERE 3333");
        return MakeOverHair();
      } else {
        print("ENTER ENTER ENTERE 444");
        return Stack(
          children: [
            Positioned(
              top: -size.height * 0.087,
              child: Container(
                height: size.height,
                width: size.width,
                child: OverflowBox(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
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
            CameraOverlay(
                zoomIn: zoomIn, zoomOut: zoomOut, capture: captureImage),
            MakeOverOverlay(
                zoomIn: zoomIn, zoomOut: zoomOut, capture: captureImage),
          ],
        );
      }
    });
  }

  void captureImage(String imageName) async {
    print('done');
    XFile image = await controller.takePicture();
    var dir = (await getExternalStorageDirectory());
    File file = File(join(dir!.path, '$imageName.jpg'));
    if (await file.exists()) {
      await file.delete();
    }
    await image.saveTo(file.path);

    ///-----implement Upload API here
    // try {
    //   log('======  upload selfie API is being called =====');
    //   var result = await sfAPIUploadUserSelfie(
    //       Provider.of<AccountProvider>(Get.context!).customerId,
    //       image,
    //       imageName);
    //   log('====== selfie uploaded and result is ::  $result ');
    // } catch (e) {
    //   log('========  Error while calling upload API   =========');
    // }

    var newImage = img.decodeImage(file.readAsBytesSync()) as img.Image;
    newImage = img.copyCrop(newImage, (newImage.height * 0.05).toInt(), 0,
        newImage.width, newImage.height);
    await file.writeAsBytes(img.encodeJpg(newImage), flush: true);
    mop.images.value = mop.images.value.map((f) {
      if (f.path != file.path) {
        return f;
      }
    }).toList();
    mop.images.value = [...mop.images.value, file].obs;
    mop.images.value.removeWhere((value) => value == null);
    print("mop image value is :: ${mop.images.value}");
  }

  void zoomIn() {
    if (_currentZoomLevel < _cameraProperties['max-zoom-level']) {
      _currentZoomLevel += 0.2;
      controller.setZoomLevel(_currentZoomLevel);
    }
  }

  void zoomOut() {
    if (_currentZoomLevel > _cameraProperties['min-zoom-level']) {
      _currentZoomLevel -= 0.2;
      controller.setZoomLevel(_currentZoomLevel);
    }
  }

  void _loadCameraProperties() async {
    _cameraProperties['max-zoom-level'] = await controller.getMaxZoomLevel();
    _cameraProperties['min-zoom-level'] = await controller.getMinZoomLevel();
  }
}
