// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/phone_verification_controller.dart';
import 'package:sofiqe/sofiqe.dart';
import 'package:sofiqe/widgets/png_icon.dart';

class OtpScreen extends StatelessWidget {
  static const id = "OTPSCREEN";

  final String phone;

  OtpScreen({Key? key, required this.phone}) : super(key: key);

  final List<FocusNode> focusNodes = List.generate(
      6,
      (index) => FocusNode(
            canRequestFocus: true,
          ));
  final List<String> otp = List.generate(6, (index) => "");
  final controller = Get.find<PhoneVerificationController>();

  Future<void> login(BuildContext context) async {
    try {
      AccountProvider accountProvider =
          Provider.of<AccountProvider>(context, listen: false);
      bool login = await accountProvider.login(
          controller.data!["email"]!, controller.data!["password"]!, context);
      if (login) {
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
        // Navigator.popUntil(
        //   context,
        //   ModalRoute.withName(RouteNames.cartScreen),
        // );
      } else {
        scaffoldMessengerKey.currentState
            ?.showSnackBar(SnackBar(content: Text("Something went wrong")));
      }
    } catch (e) {
      scaffoldMessengerKey.currentState
          ?.showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.loginCallback = () async {
      await login(context);
    };
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.08),
        child: AppBar(
          leading: IconButton(
            icon: Transform.rotate(
              angle: 3.14159,
              child: PngIcon(
                image: 'assets/icons/arrow-2-white.png',
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'sofiqe',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: size.height * 0.035,
                    letterSpacing: 0.6),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Text(
                "OTP VERIFICATION",
                style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: size.height * 0.3,
            //   width: size.width,
            //   alignment: Alignment.topCenter,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           fit: BoxFit.cover,
            //           image: AssetImage(
            //               "assets/images/otp_verification_bg.jpeg"))),
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         IconButton(
            //           icon: Transform.rotate(
            //             angle: 3.14159,
            //             child: PngIcon(
            //               image: 'assets/icons/arrow-2-white.png',
            //             ),
            //           ),
            //           onPressed: () {
            //             Get.back();
            //           },
            //         ),
            //         Spacer(
            //           flex: 1,
            //         ),
            //         Text(
            //           "Sofiqe",
            //           style: Theme.of(context)
            //               .textTheme
            //               .headline1
            //               ?.copyWith(fontSize: 30),
            //         ),
            //         Spacer(
            //           flex: 2,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "VERIFICATION",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Text("Verify the 6-digit code that were sent to $phone"),
                  Container(
                    width: size.width,
                    height: 80,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: otp.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(4),
                          width: size.width * 0.1,
                          child: TextField(
                            style: TextStyle(fontSize: 25),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              counterText: "",
                            ),
                            focusNode: focusNodes[index],
                            maxLength: 1,
                            onChanged: (value) async {
                              otp[index] = value;
                              if (value != "") {
                                if (index == 5) {
                                  if (!otp.any((element) => element == "")) {
                                    try {
                                      bool verified = await controller.verify(
                                          otp: otp.join());
                                      print('Login status: $verified');
                                    } catch (e) {
                                      Get.showSnackbar(
                                        GetSnackBar(
                                          message: 'Error $e',
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  focusNodes[index].nextFocus();
                                }
                              } else {
                                if (index != 0)
                                  focusNodes[index].previousFocus();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Obx(() => TextButton(
                      style: TextButton.styleFrom(primary: Colors.black),
                      onPressed: controller.isAutoRetrievalTimedOut.value
                          ? () {
                              controller.resendCode(phone);
                            }
                          : null,
                      child: Text(
                        controller.status ==
                                PhoneVerificationController.CODERESENT
                            ? "Code sent, you can request another after " +
                                controller.timer.toString() +
                                " seconds"
                            : controller.status ==
                                    PhoneVerificationController.VERIFYING
                                ? "Verifying... Please wait"
                                : controller.status ==
                                        PhoneVerificationController.FAILED
                                    ? "Send Code Again"
                                    : "Code sent, you can request another after " +
                                        controller.timer.toString() +
                                        " seconds",
                        style: TextStyle(fontSize: 16),
                      ))),
                ],
              ),
            ),

            /*           Row(
              children: otp
                  .map((e) => TextField(
                        onTap: null,
                        maxLength: 1,
                        onChanged: (value) {
                          e = value;
      
                        },
                      ))
                  .toList(),
            ), */
          ],
        ),
      ),
    );
  }
}