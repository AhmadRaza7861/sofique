import 'package:shared_preferences/shared_preferences.dart';


Future<Map<String, dynamic>> sfQueryForSharedPrefData(
    {required String fieldName, required PreferencesDataType type}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.containsKey('$fieldName')) {
    var returnVal;
    switch (type) {
      // case bool().runtimeType:
      case PreferencesDataType.BOOL:
        returnVal = pref.getBool('$fieldName');
        break;
      case PreferencesDataType.DOUBLE:
        returnVal = pref.getDouble('$fieldName');
        break;
      case PreferencesDataType.INT:
        returnVal = pref.getInt('$fieldName');
        break;
      case PreferencesDataType.STRING:
        returnVal = pref.getString('$fieldName');
        break;
      case PreferencesDataType.STRINGLIST:
        returnVal = pref.getStringList('$fieldName');
        break;
    }
    return {
      'found': true,
      '$fieldName': returnVal,
    };
  }
  return {
    'found': false,
  };
}

Future<void> sfStoreInSharedPrefData(
    {required String fieldName,
    required dynamic value,
    required PreferencesDataType type}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  switch (type) {
    // case bool().runtimeType:
    case PreferencesDataType.BOOL:
      pref.setBool('$fieldName', value);
      break;
    case PreferencesDataType.DOUBLE:
      pref.setDouble('$fieldName', value);
      break;
    case PreferencesDataType.INT:
      pref.setInt('$fieldName', value);
      break;
    case PreferencesDataType.STRING:
      pref.setString('$fieldName', value);
      break;
    case PreferencesDataType.STRINGLIST:
      pref.setStringList('$fieldName', value);
      break;
  }
}

Future<void> sfRemoveFromSharedPrefData({required String fieldName}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  await pref.remove('$fieldName');
}

enum PreferencesDataType { BOOL, DOUBLE, INT, STRING, STRINGLIST }
