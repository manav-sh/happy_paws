import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  var isGranted = 0.obs;
  // 0 - no status, 1 - rejected, 2 - approved
  var isActive = false.obs;

  RxBool isDataFetched = false.obs;

  Rx<Position>? currentPosition;

  // Checks if location is on or off
  // void locationEnabled() async {
  //   if (await Permission.location.serviceStatus.isEnabled) {
  //     isActive.value = true;
  //   } else {
  //     isActive.value = false;
  //   }
  // }

  // Checks if location is granted or not
  void locationStatus() async {
    if (!(await Permission.location.serviceStatus.isEnabled)) {
      Get.snackbar('Location Disabled',
          'Please turn on the location to continue using app',
          duration: const Duration(seconds: 5));
      await openAppSettings();
      isGranted.value = 1;
      return;
    }
    var status = await Permission.location.status;
    if (!status.isGranted) {
      PermissionStatus status = await Permission.location.request();
      if (!status.isGranted) {
        Get.snackbar('Permission not Granted',
            'Please provide location permission to continue using app',
            duration: const Duration(seconds: 5));
        isGranted.value = 1;
        return;
      }
    }
    isGranted.value = 2;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position.obs;
    isDataFetched.value = true;
    // print(position.latitude);
    // print(position.longitude);
  }

  Future<void> updateLocation() async {
    isDataFetched.value = false;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position.obs;
    isDataFetched.value = true;
  }
}
