import 'package:flutter/material.dart';
import 'package:happy_paws/constants/colors.dart';

Widget photoLoader(double size) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(size / 1.5),
    child: SizedBox(
      height: size,
      width: size,
      child: const ColoredBox(
        color: primaryRedLight,
        child: Center(child: Icon(Icons.person)),
      ),
    ),
  );
}

class ProcessLoaders {
  static void showLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => const Center(
        child:
            SizedBox(height: 35, width: 35, child: CircularProgressIndicator()),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
