import 'package:edelivery_flutter/theme.dart';
import 'package:edelivery_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const IconAndText({
    Key key,
    this.text,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimenssions.iconSize24,
        ),
        const SizedBox(width: 5),
        SmallText(
          text: text,
        ),
      ],
    );
  }
}
