import 'package:flutter/material.dart';

class NavBarIcon extends StatelessWidget {
  const NavBarIcon(
      {super.key,
      required this.icon,
      required this.color,
      required this.activeBg});

  final String icon;
  final Color color;
  final Color activeBg;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: activeBg,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 14),
          child: ImageIcon(
            AssetImage('assets/icons/$icon.png'),
            size: 24,
            color: color,
          ),
        ),
      ),
    );
  }
}
