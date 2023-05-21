import 'package:flutter/material.dart';

class CircularImageMarker extends StatelessWidget {
  final String imagePath;
  final double size;

  const CircularImageMarker(
      {super.key, required this.imagePath, this.size = 48.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
