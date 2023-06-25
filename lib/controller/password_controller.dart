import 'package:get/get.dart';

class PasswordVisibility extends GetxController {
  RxBool status = false.obs;

  void setStatus(bool newStatus) {
    status.value = newStatus;
  }
}
