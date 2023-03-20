// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sofiqe/screens/otp_screen.dart';
import 'package:sofiqe/utils/api/user_account_api.dart';

class PhoneVerificationController extends GetxController {
  String verificationId = "";
  static const String UNKNOWNSTATE = "UK";
  static const String FAILED = "F";
  static const String VERIFYING = "VF";
  static const String CODERESENT = "CR";
  static const String CREATINGACCOUNT = "CA";

  RxString _authStatus = UNKNOWNSTATE.obs;
  var isAutoRetrievalTimedOut = true.obs;
  String phone = "";

  Timer? _timer;

  int get timer => _timeOut.value;
  var _timeOut = 30.obs;

  late Function loginCallback;

  Map<String, String>? data;

  ///Start Timer for Code AutoRetrieval and Resend
  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timeOut.value == 0) {
          _authStatus.value = FAILED;
          timer.cancel();
        } else {
          _timeOut.value--;
        }
      },
    );
  }

  String get status => _authStatus.value;

  int? resendToken;

  Future<void> verifyPhoneNumber(String phone, Map<String, String> data) async {
    this.data = data;
    _authStatus.value = VERIFYING;
    this.phone = phone;
    return await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 30),
        verificationCompleted: _verificationComplete,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
  }

  Future<void> resendCode(String phone) async {
    this.phone = phone;
    _authStatus.value = CODERESENT;
    _startTimer();
    return await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        forceResendingToken: resendToken,
        timeout: Duration(seconds: 30),
        verificationCompleted: _verificationComplete,
        verificationFailed: _verificationFailed,
        codeSent: _codeReSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
  }

  ///Called when verification is complpeted
  void _verificationComplete(PhoneAuthCredential credential) {
    verify(phoneAuthCredential: credential);
  }

  ///Called when Veirification is failed
  void _verificationFailed(FirebaseAuthException e) {
    _authStatus.value = FAILED;
    Get.showSnackbar(
      GetSnackBar(
        message: e.message,
        duration: Duration(seconds: 2),
      ),
    );
  }

  ///Called when recieved a [codeSent] callback from firebase
  void _codeReSent(String verificationId, [int? resendToken]) {
    this.verificationId = verificationId;
    this.resendToken = resendToken;
  }

  ///Called when recieved a [codeSent] callback from firebase
  void _codeSent(String verificationId, [int? resendToken]) {
    _authStatus.value = CODERESENT;
    this.verificationId = verificationId;
    this.resendToken = resendToken;
    Get.to(OtpScreen(
      phone: phone,
    ));
    _startTimer();
  }

  ///Called when Auto Code retrieval is timed out
  void _codeAutoRetrievalTimeout(String verificationId) {
    this.verificationId = verificationId;

    isAutoRetrievalTimedOut.value = true;
  }

  Future<bool> verify({String otp = "", PhoneAuthCredential? phoneAuthCredential}) async {
    _authStatus.value = VERIFYING;
    try {
      PhoneAuthCredential? credential;
      if (phoneAuthCredential != null) {
        credential = phoneAuthCredential;
      } else {
        credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
      }
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        bool createAccount = await sfAPISignup(data!);
        await loginCallback();
        return createAccount;
      }
    } catch (e) {
      _authStatus.value = FAILED;
      rethrow;
    }
    return false;
  }
}
