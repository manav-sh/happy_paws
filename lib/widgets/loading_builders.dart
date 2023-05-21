import 'package:flutter/material.dart';
import 'package:happy_paws/constants/colors.dart';

Widget photoLoader(double size) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(size / 1.5),
    child: SizedBox(
      height: size,
      width: size,
      child: const ColoredBox(
        color: lightGrey,
        child: Center(child: Icon(Icons.person)),
      ),
    ),
  );
}
