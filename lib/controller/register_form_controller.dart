import 'package:get/get.dart';

class RegisterFormController extends GetxController {
  static RegisterFormController instance = Get.find();

  RxString email = "".obs, password = "".obs;
  RxString photoUrl = "".obs, fullname = "".obs;

  void updateValue(String value, int code) {
    // 1 = email, 2 = password, 3 = name, 4 = photoUrl;
    switch (code) {
      case 1:
        email.value = value;
        break;
      case 2:
        password.value = value;
        break;
      case 3:
        fullname.value = value;
        break;
      case 4:
        photoUrl.value = value;
        break;
    }
  }
}
