import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/natural_me_controller.dart';
import 'package:sofiqe/screens/premium_subscription_screen.dart';
import 'package:sofiqe/widgets/capsule_button.dart';
import 'package:sofiqe/widgets/my_sofiqe/profile_information.dart';
import 'package:sofiqe/widgets/translucent_background.dart';

import '../provider/account_provider.dart';
import '../utils/api/user_account_api.dart';
import 'MS5/my_selection.dart';

class MySofiqe extends StatefulWidget {
  const MySofiqe({Key? key}) : super(key: key);

  @override
  State<MySofiqe> createState() => _MySofiqeState();
}

class _MySofiqeState extends State<MySofiqe> {
  NaturalMeController controller1 = Get.put(NaturalMeController());
  @override
  void initState() {
    super.initState();
    controller1.getNaturalMe();
  }

  @override
  Widget build(BuildContext context) {
    NaturalMeController controller = Get.put(NaturalMeController());

    return Scaffold(
      body: Obx(() => controller.isNaturalMeLoading.value
          ? Center(
        child: SpinKitDoubleBounce(
          color: Color(0xffF2CA8A),
          size: 50.0,
        ),
      )
          : Container(
        child: Profile(controller),
      )),
    );
  }
}




///----- Natural Me Screen
class Profile extends StatefulWidget {
  final NaturalMeController controller;

  Profile(this.controller);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<File> getProfilePicture() async {
    var dir = (await getExternalStorageDirectory());
    File file = File(join(dir!.path, 'front_facing.jpg'));
    return file;
  }

  @override
  void initState() {
    super.initState();
  }

  Future getProfilePictureFromServer(var customId) async {
    try {
      var result = await sfAPIGetUserSelfie(customId);
      log('==== selfie result is :: $result ===');
      if (result != null) {
        return result == "Selfie has not been uploaded" ? null : result;
      } else {
        log('==== get selfie response result is null :: $result');
        return null;
      }
    } catch (e) {
      log('==== Error while getting image =====');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        ProfileInformation(),
        Expanded(
          child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30),
                    Obx(() => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [


                        ///----new
                        FutureBuilder(
                            future: getProfilePictureFromServer(
                                Provider.of<AccountProvider>(context).customerId),
                            // future: getProfilePicture(),
                            builder: (BuildContext _, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(size.height * 0.01)),
                                  child: Container(
                                      color: Colors.white,
                                      height: size.height * 0.4,
                                      width: size.height * 0.3,
                                      child: Center(
                                          child: SpinKitFadingCircle(
                                            size: 40,
                                            color: Colors.black,
                                          ))),
                                );
                              }

                              print('===== image is this ${widget.controller.naturalMeModelNew.value.getUserImagePath()} =============');

                              return snapshot.data != null
                                  ?
                              ClipRRect(
                                borderRadius:
                                BorderRadius.all(Radius.circular(size.height * 0.01)),
                                child: Container(
                                  color: Colors.white,
                                  height: size.height * 0.4,
                                  width: size.height * 0.3,
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://sofiqe.com/media/sk_profile_pic/${widget.controller.naturalMeModelNew.value.getUserImagePath()}',
                                    // imageUrl: '${snapshot.data}',
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) => SizedBox(
                                      // padding: const EdgeInsets.all(16.0),
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                        color: Colors.black,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                  // child: Image.network('${snapshot.data}'),
                                ),
                              )
                                  : ClipRRect(
                                borderRadius:
                                BorderRadius.all(Radius.circular(size.height * 0.01)),
                                child: Container(
                                    color: Colors.white,
                                    height: size.height * 0.4,
                                    width: size.height * 0.3,
                                    child: Center(
                                        child: Text(
                                          'No Image',
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ))),
                              );
                            }),

                        ///-----old


                        // widget.controller.naturalMeModelNew.value
                        //                 .customAttributes ==
                        //             null ||
                        //         widget.controller.naturalMeModelNew.value
                        //                 .getUserImagePath() ==
                        //             ""
                        //     ? SizedBox.shrink()
                        //     : Center(
                        //         child: Container(
                        //           margin: EdgeInsets.symmetric(
                        //               horizontal: size.width * 0.15),
                        //           width: size.width * 0.6,
                        //           height: size.height * 0.38,
                        //           child: Image.network(
                        //             APIEndPoints.mediaBaseUrl +
                        //                 "${widget.controller.naturalMeModelNew.value.getUserImagePath()}",
                        //             fit: BoxFit.cover,
                        //             //  height: size.height * 0.1,
                        //             //width: size.height * 0.1,
                        //           ),
                        //         ),
                        //       ),
                        SizedBox(height: 20),
                        widget.controller.naturalMeModelNew.value
                            .customAttributes ==
                            null ||
                            widget.controller.naturalMeModelNew.value
                                .getSkin() ==
                                ''
                            ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Image.asset(
                                'assets/images/no-results.png',
                                height: 60,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50),
                                child: Text(
                                  'No Info Found',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        )
                            : Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Skin colour:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${widget.controller.naturalMeModelNew.value.getSkin()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                            width: 21,
                                            height: 19,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: widget
                                                        .controller
                                                        .naturalMeModelNew
                                                        .value
                                                        .getSkin()
                                                        .toString()
                                                        .contains('#')
                                                        ? Color(
                                                        0xff707070)
                                                        : Colors.white),
                                                color: widget
                                                    .controller
                                                    .naturalMeModelNew
                                                    .value
                                                    .getSkin()
                                                    .toString()
                                                    .contains('#')
                                                    ? HexColor(widget
                                                    .controller
                                                    .naturalMeModelNew
                                                    .value
                                                    .getSkin()
                                                    .toString())
                                                    : Colors.white)),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Skin undertone: ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${widget.controller.naturalMeModelNew.value.getSkinUndertone()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                            width: 21,
                                            height: 19,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: widget
                                                        .controller
                                                        .naturalMeModelNew
                                                        .value
                                                        .getSkinUndertone()
                                                        .toString()
                                                        .contains('#')
                                                        ? Color(
                                                        0xff707070)
                                                        : Colors.white),
                                                color: widget
                                                    .controller
                                                    .naturalMeModelNew
                                                    .value
                                                    .getSkinUndertone()
                                                    .toString()
                                                    .contains('#')
                                                    ? HexColor(widget
                                                    .controller
                                                    .naturalMeModelNew
                                                    .value
                                                    .getSkinUndertone()
                                                    .toString())
                                                    : Colors.white)),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Eye colour:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${widget.controller.naturalMeModelNew.value.getEyeColorTextFromQuestionnaire()}, " +
                                              "${widget.controller.naturalMeModelNew.value.getEyeColor()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                            width: 21,
                                            height: 19,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: widget
                                                        .controller
                                                        .naturalMeModelNew
                                                        .value
                                                        .getEyeColor()
                                                        .toString()
                                                        .contains('#')
                                                        ? Color(
                                                        0xff707070)
                                                        : Colors.white),
                                                color: widget
                                                    .controller
                                                    .naturalMeModelNew
                                                    .value
                                                    .getEyeColor()
                                                    .toString()
                                                    .contains('#')
                                                    ? HexColor(widget
                                                    .controller
                                                    .naturalMeModelNew
                                                    .value
                                                    .getEyeColor()
                                                    .toString())
                                                    : Colors.white)),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Hair colour:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${widget.controller.naturalMeModelNew.value.getHairColorTextFromQuestionnaire()}, " +
                                              "${widget.controller.naturalMeModelNew.value.getHairColor()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                            width: 21,
                                            height: 19,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: widget
                                                        .controller
                                                        .naturalMeModelNew
                                                        .value
                                                        .getHairColor()
                                                        .toString()
                                                        .contains('#')
                                                        ? Color(
                                                        0xff707070)
                                                        : Colors.white),
                                                color: widget
                                                    .controller
                                                    .naturalMeModelNew
                                                    .value
                                                    .getHairColor()
                                                    .toString()
                                                    .contains('#')
                                                    ? HexColor(widget
                                                    .controller
                                                    .naturalMeModelNew
                                                    .value
                                                    .getHairColor()
                                                    .toString())
                                                    : Colors.white)),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Lip colour:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${widget.controller.naturalMeModelNew.value.getLipColor()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                            width: 21,
                                            height: 19,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: widget
                                                        .controller
                                                        .naturalMeModelNew
                                                        .value
                                                        .getLipColor()
                                                        .toString()
                                                        .contains('#')
                                                        ? Color(
                                                        0xff707070)
                                                        : Colors.white),
                                                color: widget
                                                    .controller
                                                    .naturalMeModelNew
                                                    .value
                                                    .getLipColor()
                                                    .toString()
                                                    .contains('#')
                                                    ? HexColor(widget
                                                    .controller
                                                    .naturalMeModelNew
                                                    .value
                                                    .getLipColor()
                                                    .toString())
                                                    : Colors.white)),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Allergic to:",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 2,
                                    //   child: Container(
                                    //     alignment: Alignment.centerLeft,
                                    //     child: Text(widget
                                    //         .controller
                                    //         .naturalMeModelNew
                                    //         .value
                                    //         .getAllergicToFromQuestionnaire(),
                                    //      // textAlign: TextAlign.justify,
                                    //       style: TextStyle(
                                    //           color: Colors.black, fontSize: 14),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.controller.naturalMeModelNew
                                        .value
                                        .getAllergicToFromQuestionnaire(),
                                    // textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14),
                                  ),
                                ),
                                SizedBox(height: 21),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              )),
        ),
        widget.controller.naturalMeModelNew.value.customAttributes == null ||
                widget.controller.naturalMeModelNew.value.getUserImagePath() ==
                    ""
            ? SizedBox.shrink()
            : Container(
                height: 70,
                margin: EdgeInsets.only(
                  bottom: 25
                ),
                child: GestureDetector(
                    onTap: () async {
                      Get.to(() => MySelectionMS5());
                    },
                    child: Center(
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        width: Get.width * 0.6,
                        decoration: BoxDecoration(
                            color: Color(0xffF2CA8A),
                            borderRadius: BorderRadius.circular(30 )),
                        child: Text(
                          'RECOMMENDATIONS',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    )),
              ),
      ],
    );
  }
}

class UnlimitedSofiqe extends StatelessWidget {
  const UnlimitedSofiqe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(
                'assets/images/my_sofiqe_upgrade_background.png',
              ),
            ),
          ),
        ),
        Container(
          width: size.width,
          height: size.height * 0.3,
          child: TranslucentBackground(opacity: 0.3),
        ),
        Container(
          width: size.width,
          height: size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Unlock Unlimited Sofiqe',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.white,
                  fontSize: size.height * 0.02,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              CapsuleButton(
                width: size.width * 0.75,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext c) {
                        return PremiumSubscriptionScreen();
                      },
                    ),
                  );
                },
                backgroundColor: Color(0xFFF2CA8A),
                child: Text(
                  'Subscribe',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: size.width * 0.045,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NotificationSwitch extends StatelessWidget {
  const NotificationSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width,
      color: Colors.white,
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    try
    {
      print("HEX COLOR ${hexColor}");
      return int.parse(hexColor, radix: 16);
    }
    catch(e)
    {
      return int.parse("FFECE3E4",radix: 16);
    }

  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}