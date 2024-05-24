import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService {
  static Future<bool> _isServiceEnabled() async {
    LocationPermission permission;
    try {
      final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        Get.showSnackbar(GetSnackBar(
          message: 'Nyalakan Akses Lokasi',
          duration: Duration(seconds: 2),
        ));
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.showSnackbar(GetSnackBar(
            message: 'Akses Lokasi perlu dinyalakan',
            duration: Duration(seconds: 2),
          ));
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Get.showSnackbar(GetSnackBar(
          message: 'Akses Lokasi perlu dinyalakan',
          duration: Duration(seconds: 2),
        ));
        return false;
      }
      return true;
    } on Exception catch (e) {
      print('Error from service $e');
      return false;
    }
  }

  static Future<Position?> getCurrentPosition() async {
    try {
      if (!await _isServiceEnabled()) return null;
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } on Exception catch (e) {
      print('Error from Get Current Location $e');
      return null;
    }
  }
}
