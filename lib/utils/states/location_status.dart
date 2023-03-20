import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:sofiqe/utils/states/local_storage.dart';

Future<String> sfGetLocation() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return '';
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return '';
    }
  }

  _locationData = await location.getLocation();
  List<geo.Placemark> placemarks;
  if (_locationData.latitude != null && _locationData.longitude != null) {
    placemarks = await geo.placemarkFromCoordinates(_locationData.latitude!, _locationData.longitude!);
    return '${placemarks[0].country}';
  }
  return '';
}

Future<LocationData> getCoordinates() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      throw 'service not available';
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      throw 'permission not granted';
    }
  }

  _locationData = await location.getLocation();

  List<geo.Placemark> placemarks;
  if (_locationData.latitude != null && _locationData.longitude != null) {
    placemarks = await geo.placemarkFromCoordinates(_locationData.latitude!, _locationData.longitude!);
    sfStoreInSharedPrefData(fieldName: 'country-code', value: placemarks[0].isoCountryCode, type: PreferencesDataType.STRING);
  }

  return _locationData;
}
