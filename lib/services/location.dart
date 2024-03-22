import 'package:geolocator/geolocator.dart';

class Location {
  Location({ this.longitude, this.latitude});
  double? latitude, longitude;

  Future<void> getCurrentLocation() async {
    try {
      //LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}