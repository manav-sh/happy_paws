// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  var index = 0.obs;

  void changeIndex(int index) {
    this.index.value = index;
  }

  bool isActive(int index) => (this.index.value == index ? true : false);
}
