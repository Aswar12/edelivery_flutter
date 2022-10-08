import 'package:edelivery_flutter/theme.dart';
import 'package:edelivery_flutter/widgets/big_text.dart';
import 'package:edelivery_flutter/widgets/icon_and_text.dart';
import 'package:edelivery_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';

class AppColumn extends StatelessWidget {
  String text;
  AppColumn({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimenssions.font26,
        ),
        SizedBox(height: Dimenssions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: mainColor,
                  size: 15,
                ),
              ),
            ),
            SizedBox(width: 10),
            SmallText(text: "4,5"),
            SizedBox(width: 10),
            SmallText(text: '1244'),
            SizedBox(width: 10),
            SmallText(text: 'Reviews'),
          ],
        ),
        SizedBox(height: Dimenssions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
              text: 'Normal',
              icon: Icons.circle_sharp,
              iconColor: iconColor,
            ),
            IconAndText(
              text: '1.4 Km',
              icon: Icons.location_on,
              iconColor: mainColor,
            ),
            IconAndText(
              text: '20 Min',
              icon: Icons.access_time_rounded,
              iconColor: iconColor1,
            )
          ],
        )
      ],
    );
  }
}
