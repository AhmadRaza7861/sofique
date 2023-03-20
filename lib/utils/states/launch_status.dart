// 3rd party packages
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> sfDidAppLaunchFirstTime() async {
  SharedPreferences prefInstance = await SharedPreferences.getInstance();
  if (prefInstance.containsKey('app-launched-once')) {
    return (prefInstance.getBool('app-launched-once') as bool);
  } else {
    return true;
  }
}

Future<void> sfAppLaunchedOnce() async {
  SharedPreferences prefInstance = await SharedPreferences.getInstance();
  prefInstance.setBool('app-launched-once', false);
}
