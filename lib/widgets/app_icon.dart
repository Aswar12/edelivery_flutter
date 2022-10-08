import 'package:edelivery_flutter/theme.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  const AppIcon({
    Key key,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xff756d54),
    this.size = 40,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor),
      child: Icon(
        icon,
        size: Dimenssions.iconSize16,
        color: iconColor,
      ),
    );
  }
}
