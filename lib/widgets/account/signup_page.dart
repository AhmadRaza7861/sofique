// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sofiqe/provider/phone_verification_controller.dart';
import 'package:sofiqe/sofiqe.dart';
import 'package:sofiqe/utils/api/user_account_api.dart';
import 'package:sofiqe/utils/states/local_storage.dart';
import 'package:sofiqe/widgets/account/gender_selector.dart';
import 'package:sofiqe/widgets/account/phone_number_field.dart';
import 'package:sofiqe/widgets/account/signup_form_field.dart';
import 'package:sofiqe/widgets/capsule_button.dart';

// bool isSignUpProcessing = false;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays([]);

    ///todo: uncomment
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  }

  PhoneVerificationController controller = Get.put(PhoneVerificationController());
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController phoneNumberCodeController = TextEditingController(text: "+41");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      color: Colors.white,
      child: SignupForm(
        firstNameController: firstNameController,
        middleNameController: middleNameController,
        lastNameController: lastNameController,
        dobController: dobController,
        emailController: emailController,
        genderController: genderController,
        passwordController: passwordController,
        phoneNumberController: phoneNumberController,
        phoneNumberCodeController: phoneNumberCodeController,
        signup: () async {
          // setState(() {
          //   isSignUpProcessing = true;
          // });

          await _initiatePhoneValidation(context);
        },
      ),
    );
  }

  Future<void> _initiatePhoneValidation(BuildContext c) async {
    String phoneNumber = '${phoneNumberCodeController.value.text}${phoneNumberController.value.text}';
    bool validated = await _validate();
    if (!validated || phoneNumberController.text.trim().isEmpty) {
      return;
    }
    await sfStoreInSharedPrefData(
        fieldName: 'phone-number', value: phoneNumberController.value.text, type: PreferencesDataType.STRING);
    Map<String, String> newUserInformation = {
      'firstname': '${firstNameController.value.text}',
      'lastname': '${lastNameController.value.text}',
      'middlename': ' ',
      'dob': getDateFromText(),
      'gender': '${genderController.value.text}',
      'email': '${emailController.value.text}',
      'password': '${passwordController.value.text}',
      'phone': '${phoneNumberController.value.text}',
    };

    try {
      print(phoneNumber);
      await controller.verifyPhoneNumber(phoneNumber, newUserInformation);
      // setState(() {
      //   isSignUpProcessing = false;
      // });
    } catch (e) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('An unexpected error occured.'),
        ),
      );
    }
  }

  String getDateFromText() {
    String date = dobController.text;
    List datelist = date.split("/");
    String dateReFormate = datelist[2] + "-" + datelist[1] + "-" + datelist[0];
    return DateTime.parse(dateReFormate).toString();
  }

  Future<bool> _validate() async {
    if (dobController.value.text.isEmpty) {
      Get.showSnackbar(GetSnackBar(
        message: 'Select date of birth',
        duration: Duration(seconds: 2),
      ));
    }

    if (phoneNumberController.text.trim().length < 4) {
      Get.showSnackbar(GetSnackBar(
        message: 'Phone number is not valid',
        duration: Duration(seconds: 2),
      ));
      return false;
    }

    if (!EmailValidator.validate(emailController.value.text)) {
      Get.showSnackbar(GetSnackBar(
        message: 'Email is not in proper format',
        duration: Duration(seconds: 2),
      ));
      return false;
    }
    if (!(await sfAPIEmailAvailable(emailController.value.text))) {
      Get.showSnackbar(GetSnackBar(
        message: 'Email is already in use',
        duration: Duration(seconds: 2),
      ));

      return false;
    }

    if (!_validatePassword()) {
      Get.showSnackbar(GetSnackBar(
        message:
            'Password must contain at least one digit, one special character and combination of upper and lower case characters for a total of 8 characters.',
        duration: Duration(seconds: 2),
      ));

      return false;
    }
    if (phoneNumberController.text.trim().length < 4) {
      Get.showSnackbar(GetSnackBar(
        message: 'Phone number is not valid',
        duration: Duration(seconds: 2),
      ));
      return false;
    }
    if (dobController.text.length < 10) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Please Enter a Valide Date'),
        ),
      );
      return false;
    } else {
      String date = dobController.text;
      List datelist = date.split("/");
      String dateReFormate = datelist[2] + "-" + datelist[1] + "-" + datelist[0];
      try {
        DateTime.parse(dateReFormate);
      } catch (e) {
        SnackBar(
          content: Text(e.toString()),
        );
        return false;
      }
    }

    return true;
  }

  bool _validatePassword() {
    String password = passwordController.value.text;
    bool containsUpper = password.contains(RegExp(r'[A-Z]'));
    bool containsAlpha = password.contains(RegExp(r'[A-Za-z]'));
    bool containsNumeric = password.contains(RegExp(r'[0-9]'));
    bool containsSpecial = password.contains(RegExp(r'[^A-Za-z0-9]'));
    bool minimumChar = password.length >= 8;
    if (containsUpper && containsAlpha && containsNumeric && containsSpecial && minimumChar) {
      return true;
    } else {
      return false;
    }
  }
}

class SignupForm extends StatefulWidget {
  SignupForm({
    Key? key,
    required this.firstNameController,
    required this.middleNameController,
    required this.lastNameController,
    required this.dobController,
    required this.emailController,
    required this.genderController,
    required this.passwordController,
    required this.phoneNumberController,
    required this.phoneNumberCodeController,
    required this.signup,
  }) : super(key: key);
  final Function signup;
  final TextEditingController phoneNumberController;
  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final TextEditingController dobController;
  final TextEditingController emailController;
  final TextEditingController genderController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumberCodeController;

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String initialValue = 'Male';

  @override
  initState() {
    super.initState();
    widget.genderController.text = '0';
  }

 
  bool fname = false;
  bool lname = false;
  bool email = false;
  bool password = false;
  bool phone = false;
  bool dob = false;
  FocusNode focusNodeFirstName = FocusNode();
  FocusNode focusNodeLastName = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePhoneNo = FocusNode();
  FocusNode focusNodeDateofBirth = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodeDOB = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        width: size.width,
        child: Column(
          children: [
            _Header(),
            GenderSelector(
              onSelect: (newGender) {
                switch (newGender) {
                  case 'male':
                    widget.genderController.text = '0';
                    break;
                  case 'female':
                    widget.genderController.text = '1';
                    break;
                  case 'genderless':
                    widget.genderController.text = '2';
                    break;
                  case 'lgbt':
                    widget.genderController.text = '3';
                    break;
                }
              },
            ),
            Divider(
              color: Color(0xFFE5E1DC),
              height: size.height * 0.004,
            ),
            SignUpFormField(
              onTap: () {
                fname = true;
                lname = false;
                email = false;
                password = false;
                phone = false;
                dob = false;
                setState(() {});
                focusNodeFirstName.requestFocus();
              },
              focusNode: focusNodeFirstName,
              onSubmitted: (p0) {
                setState(() {
                  fname = false;
                  lname = true;
                  email = false;
                  password = false;
                  phone = false;
                  dob = false;
                });
                focusNodeLastName.requestFocus();
              },
              isBeingEdited: fname,
              width: size.width,
              label: 'MY FIRST NAME IS',
              controller: widget.firstNameController,
              inputType: TextInputType.name,
            ),
            SignUpFormField(
              onTap: () {
                fname = false;
                lname = true;
                email = false;
                password = false;
                phone = false;
                dob = false;
                focusNodeLastName.requestFocus();
                setState(() {});
              },
              onSubmitted: (p0) {
                setState(() {
                  fname = false;
                  lname = false;
                  email = true;
                  password = false;
                  phone = false;
                  dob = false;
                });
                focusNodeEmail.requestFocus();
              },
              focusNode: focusNodeLastName,
              isBeingEdited: lname,
              width: size.width,
              label: 'MY LAST NAME IS',
              controller: widget.lastNameController,
              inputType: TextInputType.name,
            ),
            SignUpFormField(
              onTap: () {
                fname = false;
                lname = false;
                email = true;
                password = false;
                phone = false;
                dob = false;
                setState(() {});
                focusNodeEmail.requestFocus();
              },
              onSubmitted: (p0) {
                setState(() {
                  fname = false;
                  lname = false;
                  email = false;
                  password = true;
                  phone = false;
                  dob = false;
                });
                focusNodePassword.requestFocus();
              },
              focusNode: focusNodeEmail,
              isBeingEdited: email,
              width: size.width,
              label: 'MY EMAIL IS',
              controller: widget.emailController,
            ),
            SignUpFormField(
              onTap: () {
                fname = false;
                phone = false;
                lname = false;
                email = false;
                password = true;
                dob = false;
                focusNodePassword.requestFocus();
                setState(() {});
              },
              onSubmitted: (p0) {
                setState(() {
                  fname = false;
                  lname = false;
                  email = false;
                  password = false;
                  phone = true;
                  dob = false;
                });
                focusNodePhoneNo.requestFocus();
              },
              focusNode: focusNodePassword,
              isBeingEdited: password,
              obscure: true,
              width: size.width,
              label: 'MY PASSWORD IS',
              controller: widget.passwordController,
            ),
            PhoneNumberField(
              onTap: () {
                fname = false;
                phone = false;
                lname = false;
                email = false;

                password = false;
                dob = true;
                focusNodePhoneNo.requestFocus();
                setState(() {});
              },
              onSubmitted: (p0) {
                fname = false;
                phone = false;
                lname = false;
                email = false;
                password = false;
                dob = true;
                focusNodeDOB.requestFocus();
                setState(() {});
              },
              focusNode: focusNodePhoneNo,
              isBeingEdited: phone,
              phoneNumberController: widget.phoneNumberController,
              phoneNumberCodeController: widget.phoneNumberCodeController,
              // phoneNumberCodeController: widget.phoneNumberCodeController,
            ),
            SignUpFormField(
              onTap: () {
                fname = false;
                phone = false;
                lname = false;
                email = false;
                password = false;
                dob = true;
                focusNodeDOB.requestFocus();
                setState(() {});
              },
              onSubmitted: (p0) {
                setState(() {
                  fname = false;
                  lname = false;
                  email = false;
                  password = false;
                  phone = false;
                  dob = false;
                });
                focusNodeDOB.unfocus();
              },
              inputType: TextInputType.datetime,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
                CardMonthInputFormatter(),
              ],
              placeHolder: "DD/MM/YYYY",
              focusNode: focusNodeDOB,
              isBeingEdited: dob,
              width: size.width,
              label: 'MY DATE OF BIRTH IS',
              controller: widget.dobController,
            ),
            // GestureDetector(
            //   onTap: () {
            //     fname = false;
            //     lname = false;
            //     email = false;
            //     password = false;
            //     phone = false;
            //     setState(() {});
            //     _selectDate(context);
            //   },
            //   child: SignUpDateField(
            //     // isBeingEdited: email,
            //     width: size.width,
            //     label: 'MY DATE OF BIRTH IS',
            //     controller: widget.dobController,
            //   ),
            // ),
            Divider(
              color: Color(0xFFE5E1DC),
              height: size.height * 0.004,
            ),
            SignupButton(
              text: "GO",
              signup: widget.signup,
              firstNameController: widget.firstNameController,
              middleNameController: widget.middleNameController,
              lastNameController: widget.lastNameController,
              dobController: widget.dobController,
              emailController: widget.emailController,
              genderController: widget.genderController,
              passwordController: widget.passwordController,
              phoneNumberController: widget.phoneNumberController,
              phoneNumberCodeController: widget.phoneNumberCodeController,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.036, horizontal: size.width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YOU’RE IN!',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: size.height * 0.028,
                  color: Colors.black,
                ),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Welcome to ',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: size.height * 0.014,
                      letterSpacing: 0.2,
                    ),
              ),
              TextSpan(
                text: 'sofiqe. ',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.black,
                      fontSize: size.height * 0.018,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(
                text: 'Complete your member profile',
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.black,
                      fontSize: size.height * 0.014,
                      letterSpacing: 0.2,
                    ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class SignupButton extends StatefulWidget {
  final Function signup;
  final String text;

  final TextEditingController phoneNumberController;
  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final TextEditingController dobController;
  final TextEditingController emailController;
  final TextEditingController genderController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumberCodeController;
  const SignupButton({
    Key? key,
    required this.signup,
    required this.text,
    required this.firstNameController,
    required this.middleNameController,
    required this.lastNameController,
    required this.dobController,
    required this.emailController,
    required this.genderController,
    required this.passwordController,
    required this.phoneNumberController,
    required this.phoneNumberCodeController,
  }) : super(key: key);

  @override
  _SignupButtonState createState() => _SignupButtonState();
}

class _SignupButtonState extends State<SignupButton> {
  @override
  initState() {
    super.initState();
    widget.firstNameController.addListener(rebuildOnChange);
    widget.lastNameController.addListener(rebuildOnChange);
    widget.dobController.addListener(rebuildOnChange);
    widget.emailController.addListener(rebuildOnChange);
    widget.genderController.addListener(rebuildOnChange);
    widget.passwordController.addListener(rebuildOnChange);
    widget.phoneNumberController.addListener(rebuildOnChange);
    widget.phoneNumberCodeController.addListener(rebuildOnChange);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void rebuildOnChange() {
    // setState(() {});
  }

  bool changed = true;

  bool _checkEmpty() {
    if (widget.firstNameController.value.text.isEmpty ||
        widget.lastNameController.value.text.isEmpty ||
        widget.dobController.value.text.isEmpty ||
        widget.emailController.value.text.isEmpty ||
        widget.genderController.value.text.isEmpty ||
        widget.passwordController.value.text.isEmpty ||
        widget.phoneNumberController.value.text.isEmpty ||
        widget.phoneNumberCodeController.value.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Color backgroundColor = Colors.black;
    bool empty = false;

    if (_checkEmpty() == true) {
      backgroundColor = Colors.black38;
      empty = true;
    } else {
      empty = false;
    }

    return Container(
      width: size.width * 0.7,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: size.width * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CapsuleButton(
            width: size.width * 0.8,
            height: size.width * 0.15,
            backgroundColor: backgroundColor,
            borderColor: Colors.transparent,
            onPress: () {
              if (_checkEmpty() == true) {
                backgroundColor = Colors.black38;
                empty = true;
              } else
                empty = false;

              if (empty) {
                if (changed) {
                  changed = false;
                  Timer(Duration(seconds: 3), () {
                    changed = true;
                  });
                  Get.showSnackbar(GetSnackBar(
                    message: 'Please fill out all fields with valid details',
                    duration: Duration(seconds: 2),
                  ));
                }
              } else {
                if (changed) {
                  changed = false;
                  Timer(Duration(seconds: 3), () {
                    changed = true;
                  });
                  widget.signup();
                }
              }
            },
            child: Text(
              widget.text.toUpperCase(),
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Color(0xFFF2CA8A),
                    fontSize: size.height * 0.02,
                    letterSpacing: 0.7,
                  ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'By continuing, you agree to Sofique’s Terms & Conditions and Privacy Policy',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                  fontSize: size.height * 0.01,
                  letterSpacing: 0.7,
                ),
          ),
        ],
      ),
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (buffer.toString().length < 6) {
        if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
          buffer.write('/');
        }
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }
}
