import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationService {
  double? latitude, longitude;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permission;

    serviceEnabled = await Location().serviceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Location().requestPermission();
    if (permission != PermissionStatus.granted) {
      return false;
    }

    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;

    try {
      LocationData locationData = await Location().getLocation();
      latitude = locationData.latitude;
      longitude = locationData.longitude;
    } catch (e) {
      print(e);
    }
  }

  LatLng? getLatLng() {
    if (latitude != null && longitude != null) {
      return LatLng(latitude!, longitude!);
    } else {
      return null;
    }
  }
}
