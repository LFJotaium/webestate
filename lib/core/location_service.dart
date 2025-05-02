import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:latlong2/latlong.dart';

class LocationService {
  Future<bool> checkPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return false;
      }

      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return false;

      return true;
    } catch (e) {
      print("Permission check failed: $e");
      return false;
    }
  }

  Future<LatLng?> getCurrentLocation() async {
    if (!await checkPermission()) return null;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting current location: $e");
      return null;
    }
  }

  Future<List<String?>?> getAddressFromLatLng(LatLng position) async {
    try {
      final placemarks = await geo.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return [place.street, place.locality, place.country];
      }
      return null;
    } catch (e) {
      print("Error getting address from coordinates: $e");
      return null;
    }
  }
}
