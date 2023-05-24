import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMsg(String txt) {
  Fluttertoast.showToast(
    msg: txt,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    timeInSecForIosWeb: 1,
  );
}
