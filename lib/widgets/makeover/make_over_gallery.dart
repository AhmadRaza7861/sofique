// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/fabController.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/make_over_provider.dart';
import 'package:sofiqe/utils/states/profile_picture.dart';
import 'package:sofiqe/widgets/capsule_button.dart';
import 'package:sofiqe/widgets/makeover/total_make_over/total_make_over.dart';
import 'package:sofiqe/widgets/png_icon.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class MakeOverGallery extends StatelessWidget {
  MakeOverGallery({Key? key}) : super(key: key);

  // late List<File> fileList;

  final MakeOverProvider mop = Get.find();

  Future<void> _createProfilePicture(afterStoreCallback) async {
    var dir = (await getExternalStorageDirectory());
    File file = File(join(dir!.path, 'front_facing.jpg'));
    await sfCreateProfilePicture(file);
    afterStoreCallback();
  }

  final List<String> shareList = [];
bool warn = true;
  @override
  Widget build(BuildContext context) {
    if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
      mop.sendResponse(Provider.of<AccountProvider>(context, listen: false).customerId);
    }
    _createProfilePicture(
      () {
        if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
          Provider.of<AccountProvider>(context, listen: false).saveProfilePicture();
        }
      },
    );
    Size size = MediaQuery.of(context).size;

    bool canShowSnackBar = true;

    return Stack(
      children: [
        Container(
          // height: size.height,
          // width: size.wid,
          child: Stack(
            children: [
              Obx(() {
                return Column(
                  children: [
                    ...mop.images.value.map(
                          (file) {
                        return _CapturedSelfie(image: file, toggleSelect: _toggleSelect);
                      },
                    ).toList(),
                  ],
                );
              }),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'sofiqe',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: size.height * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CapsuleButton(
                          width: size.width * 0.3,
                          backgroundColor: Colors.white,
                          onPress: () async {
                            print("yes this is");
                            // Get.to(()=>Warning(
                            //
                            // ));
                            Get.defaultDialog(
                                title: "",
                                barrierDismissible: false,
                                backgroundColor: Colors.black,
                                content: Warning(forward: (){
                                  warn = false;
                                  final FABController fabController = Get.find();
                                  fabController.showFab.value = false;
                                  if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
                                    mop.screen.value = 4;
                                    mop.sendResponse(Provider.of<AccountProvider>(context, listen: false).customerId);
                                  } else {
                                    mop.screen.value = 3;
                                  }
                                  Navigator.pop(context, false);
                                },
                                    reset: (){
                                  mop.reset();
                                  mop.screen.value = 1;
                                  Navigator.pop(context, false);
                                })
                            );
                            // if (Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
                            //   mop.screen.value = 4;
                            //   mop.sendResponse(Provider.of<AccountProvider>(context, listen: false).customerId);
                            // } else {
                            //   mop.screen.value = 3;
                            // }
                          },
                          child: Text(
                            'YES',
                            style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.black,
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                        CapsuleButton(
                          // width: size.width * 0.35,
                          backgroundColor: Colors.black,
                          onPress: () {
                            mop.screen.value = 1;
                            mop.currentPrompt.value = 0;
                            mop.images.value = [].obs;

                            imageCache.clear();
                          },
                          child: Text(
                            'RETAKE',
                            style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.white,
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (shareList.isEmpty) {
                              if (canShowSnackBar) {
                                canShowSnackBar = false;
                                Timer(
                                  Duration(seconds: 3),
                                      () {
                                    canShowSnackBar = true;
                                  },
                                );
                                Get.showSnackbar(
                                  GetSnackBar(
                                    message: 'Please select an image to share',
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                              return;
                            }
                            await Share.shareFiles(shareList);
                          },
                          child: Container(
                            width: size.height * 0.08,
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(60)),
                              color: Color(0xFFF2CA8A),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PngIcon(
                                  image: 'assets/icons/share/send@3x.png',
                                  padding: EdgeInsets.only(left: 4),
                                  height: size.height * 0.038,
                                  width: size.height * 0.038,
                                ),
                                SizedBox(height: size.height * 0.005),
                                Text(
                                  'SHARE',
                                  style: Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Colors.black,
                                    fontSize: size.height * 0.012,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: size.height * 0.12),
          alignment: Alignment.bottomCenter,
          child: _FloatingApproval(),
        ),
      ],
    );
  }

  void _toggleSelect(File image) {
    if (shareList.contains(image.path)) {
      shareList.remove(image.path);
    } else {
      shareList.add(image.path);
    }
  }
}

class _CapturedSelfie extends StatefulWidget {
  final File image;
  final Function toggleSelect;
  _CapturedSelfie({Key? key, required this.image, required this.toggleSelect}) : super(key: key);

  @override
  __CapturedSelfieState createState() => __CapturedSelfieState();
}

class __CapturedSelfieState extends State<_CapturedSelfie> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          widget.toggleSelect(widget.image);
          selected = !selected;
          setState(() {});
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.file(widget.image, fit: BoxFit.cover),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white, width: selected ? 1 : 0),
              // ),
            ),
            selected
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.check_box,
                        color: Color(0xFFF2CA8A),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class _FloatingApproval extends StatefulWidget {
  const _FloatingApproval({Key? key}) : super(key: key);

  @override
  __FloatingApprovalState createState() => __FloatingApprovalState();
}

class __FloatingApprovalState extends State<_FloatingApproval> {
  bool display = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (!display) {
      return Container();
    }
    return Container(
      width: size.width * 0.50,
      // height: size.height * 0.18,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: size.width * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Image Approval',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.1,
                      fontSize: size.height * 0.02,
                    ),
              ),
              GestureDetector(
                onTap: () {
                  display = false;
                  setState(() {});
                },
                child: PngIcon(image: 'assets/images/path_11.png'),
              ),
            ],
          ),
          Text(
            'Please scroll down and review\nthe selfie.\n\nAre you happy with the photo?',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.white,
                  letterSpacing: 0.1,
                  fontSize: size.height * 0.014,
                ),
          ),
        ],
      ),
    );
  }
}