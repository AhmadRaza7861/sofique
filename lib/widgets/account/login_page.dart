// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/controller/controllers.dart';
import 'package:sofiqe/provider/account_provider.dart';
import 'package:sofiqe/provider/cart_provider.dart';
import 'package:sofiqe/provider/page_provider.dart';
import 'package:sofiqe/provider/try_it_on_provider.dart';
import 'package:sofiqe/utils/api/user_account_api.dart';
import 'package:sofiqe/widgets/capsule_button.dart';
import 'package:sofiqe/widgets/custom_form_field_login.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool load = false;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    // return super.toString(minLevel: DiagnosticLevel.info);
    return 'LOGINPAGE';
  }

  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);

    ///todo: uncomment
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: [SystemUiOverlay.top]);
  }

  // final TextEditingController userNameController = TextEditingController();

  // final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController(text: "farooqaziz20@gmail.com");

  final TextEditingController passwordController = TextEditingController(text: "Aspire20@");

  final PageProvider pp = Get.find();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height - AppBar().preferredSize.height,
        child:
            // load == true
            //     ? Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Center(
            //             child: SpinKitDoubleBounce(
            //               color: Color(0xffF2CA8A),
            //               size: 50.0,
            //             ),
            //           )
            //         ],
            //       )
            //     :
            ModalProgressHUD(
          inAsyncCall: load,
          progressIndicator: SpinKitDoubleBounce(
            color: Colors.black,
            // color: Color(0xffF2CA8A),
            size: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LoginForm(
                  userNameController: userNameController,
                  passwordController: passwordController,
                ),
              ),
              LoginButton(
                login: () {
                  _login(context);
                },
                emailController: userNameController,
                passwordController: passwordController,
              ),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext c) async {
    setState(() {
      load = true;
    });
    try {
      if (await Provider.of<AccountProvider>(c, listen: false)
          .login('${userNameController.value.text}', '${passwordController.value.text}', c)) {
        print("CONTROLL ENTER 1111");

        makeOverProvider.tryitOn.value = true;
        profileController.screen.value = 0;
        profileController.getUserProfile();
        
        print("CONTROLL ENTER 22222");
        // final TryItOnProvider tiop = await Get.put(TryItOnProvider());
        // final SelectedProductController select = await Get.put(SelectedProductController());
        // tiop.getCentralColors();
        Navigator.pop(c);
// <<<<<<< HEAD

        setState(() {
          load = false;
        });
        // pp.goToPage(Pages.MAKEOVER);

        await Provider.of<CartProvider>(context, listen: false).genrateCart();
        Provider.of<CartProvider>(context, listen: false).update(true, 160);
// =======
//       //     pp.goToPage(Pages.MAKEOVER);
// >>>>>>> bd28e4e10403ca20a15a8cf1a199a9e704212cb5
        Provider.of<CartProvider>(context, listen: false).fetchCartDetails();
      } else {
        setState(() {
          load = false;
        });
        // ScaffoldMessenger.of(c).showSnackBar(SnackBar(
        //   content: Text('Incorrect Username or Password'),
        // ));
      }
    } catch (e) {
      print('========= Something Went wrong :: Error - $e  =======');
      if (mounted)
        setState(() {
          load = false;
        });
    }
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key? key, required this.userNameController, required this.passwordController}) : super(key: key);
  final TextEditingController userNameController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool resetFuncIsBeingCalled = false;

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: size.width,
      color: Color(0xFFF4F2F0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.07),
          Text(
            'WELCOME BACK',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: 13,
                  letterSpacing: 0.55,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: size.height * 0.07),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomFormFieldLogin(
                  label: 'EMAIL',
                  controller: widget.userNameController,
                  width: size.width * 0.8,
                  height: size.height * 0.07,
                ),
                SizedBox(height: size.height * 0.033),
                CustomFormFieldLogin(
                  obscure: !showPassword,
                  suffix: InkWell(
                      onTap: () {
                        print("test");
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: showPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off))),
                  label: 'PASSWORD',
                  controller: widget.passwordController,
                  width: size.width * 0.8,
                  height: size.height * 0.07,
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.023),
          Container(
            alignment: Alignment.centerRight,
            width: size.width * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password Format'.toUpperCase(),
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: size.height * 0.014,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'Password must contain at least one digit, one special character and combination of upper and lower case characters for a total of 8 characters.',
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: size.height * 0.014,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: size.height * 0.014,
                      letterSpacing: 0.5,
                    ),
                  ),
                  onPressed: () async {
                    if (widget.userNameController.value.text.isEmail) {
                      setState(() {
                        resetFuncIsBeingCalled = true;
                      });
                      try {
                        bool success = await sfAPIResetPassword(widget.userNameController.value.text);
                        if (success) {
                          setState(() {
                            resetFuncIsBeingCalled = false;
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext c) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: ResetPasswordMessage(),
                              );
                            },
                          );
                        }
                      } catch (err) {
                        setState(() {
                          resetFuncIsBeingCalled = false;
                        });
                        print('Error resetting password: $err');
                        Map responseBody = json.decode(err as String);
                        if (responseBody['message'].compareTo(
                            'No such entity with %fieldName = %fieldValue, %field2Name = %field2Value') ==
                            0) {
                          Get.showSnackbar(
                            GetSnackBar(
                              message: 'The account doesn\'t exist',
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          Get.showSnackbar(
                            GetSnackBar(
                              message: 'An unexpected error occurred',
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    } else {
                      setState(() {
                        resetFuncIsBeingCalled = false;
                      });
                      Get.showSnackbar(
                        GetSnackBar(
                          message: 'Enter a valid email address to reset password',
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                resetFuncIsBeingCalled
                    ? Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SpinKitFadingCircle(
                      color: Colors.black,
                      // color: Color(0xffF2CA8A),
                      size: 20.0,
                    ),
                  ],
                )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatefulWidget {
  final Function login;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({Key? key, required this.login, required this.emailController, required this.passwordController})
      : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  initState() {
    super.initState();
    widget.emailController.addListener(rebuildOnChange);
    widget.passwordController.addListener(rebuildOnChange);
  }

  @override
  void dispose() {
    widget.emailController.removeListener(rebuildOnChange);
    widget.passwordController.removeListener(rebuildOnChange);
    super.dispose();
  }

  void rebuildOnChange() {
    changed = true;
    setState(() {});
  }

  bool validate() {
    bool email = EmailValidator.validate(widget.emailController.value.text);
    bool password = widget.passwordController.value.text.length >= 8;

    return (email && password);
  }

  bool changed = true;
final TryItOnProvider tiop=Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Color backgroundColor = Colors.black;
    bool empty = false;
    if (widget.emailController.value.text.isEmpty || widget.passwordController.value.text.isEmpty) {
      backgroundColor =Colors.black38;
      empty = true;
    } else if (!validate()) {
      backgroundColor = Colors.black38;
      empty = true;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: size.width * 0.08),
      child: Center(
        child: Obx(()=>
            CapsuleButton(
            width: size.width * 0.8,
            height: size.width * 0.17,
            backgroundColor: tiop.isChangeButtonColor.isTrue && tiop.sku.value=="12345678"?tiop.ontapColor:backgroundColor,
            borderColor: Colors.transparent,
            onPress: () {
              tiop.sku.value="12345678";
              tiop.isChangeButtonColor.value=true;
              tiop.playSound();
              Future.delayed(Duration(milliseconds: 10)).then((value)
              {
                tiop.isChangeButtonColor.value=false;
                tiop.sku.value="";
                if (empty) {
                  if (changed) {
                    changed = false;
                    Get.showSnackbar(GetSnackBar(
                      message: 'Please enter a valid username and password',
                      duration: Duration(seconds: 2),
                    ));
                  }
                } else {
                  if (changed) {
                    changed = false;
                    widget.login();
                  }
                }
              });

            },
            child: Text(
              'LOGIN',
              style:
              Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white, fontSize: 14, letterSpacing: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordMessage extends StatelessWidget {
  const ResetPasswordMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.03),
      alignment: Alignment.center,
      height: size.height * 0.2,
      width: size.width * 0.4,
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Color(0xFFF2CA8A),
          )),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                Text(
                  'sofiqe',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Color(0xFFF2CA8A),
                        fontSize: size.height * 0.04,
                        height: 1,
                      ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.025),
          Text(
            'An email has been sent with a link to reset your password',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.white,
                  fontSize: size.height * 0.02,
                ),
          ),
        ],
      ),
    );
  }
}