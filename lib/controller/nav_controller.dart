import 'package:get/get.dart';

// controller for hide navigation bar
class NavController extends GetxController {
  bool navbar = false;

  // set bool true and false
  setnavbar(bool val) {
    this.navbar = val;
    update();

  }
}