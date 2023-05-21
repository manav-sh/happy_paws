import 'package:flutter/material.dart';
import 'package:happy_paws/constants/colors.dart';
import 'package:happy_paws/widgets/loading_builders.dart';

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

class NetWorkImageIcon extends StatelessWidget {
  const NetWorkImageIcon(
      {super.key,
      required this.imageUrl,
      required this.activeBg,
      required this.size,
      required this.borderSize});

  final String imageUrl;
  final Color activeBg;
  final double size, borderSize;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(size / 1.5),
        child: ColoredBox(
          color: activeBg,
          child: Padding(
            padding: EdgeInsets.all(borderSize),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(size / 1.5),
                child: Image.network(imageUrl,
                    height: size, width: size, fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return photoLoader(size);
                })),
          ),
        ));
  }
}
