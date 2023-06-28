import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickingController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  RxBool imageSelected = false.obs;
  Rx<File?> photo = (null as File?).obs;

  Future getImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      photo.value = File(pickedImage.path);
      // print('HELLLO... Not null');
      imageSelected.value = true;
    } else {
      if (photo.value == null) {
        imageSelected.value = false;
      }
    }
  }
}
