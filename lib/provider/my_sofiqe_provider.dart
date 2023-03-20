import 'package:get/get.dart';

class MySofiqeProvider extends GetxController {
  Rx<MySofiqePage> page = MySofiqePage.MYSOFIQEHOME.obs;

  /// Constructor
  MySofiqeProvider();

  /// Defaults
  defaults() {
    page.value = MySofiqePage.MYSOFIQEHOME;
  }
}

enum MySofiqePage {
  MYSOFIQEHOME,
}
