import 'dart:ffi';

import 'package:edelivery_flutter/theme.dart';
import 'package:edelivery_flutter/widgets/big_text.dart';
import 'package:edelivery_flutter/widgets/icon_and_text.dart';
import 'package:edelivery_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

class AppColumn extends StatelessWidget {
  String name;
  String kedai;
  String category;
  dynamic price;
  AppColumn({Key key, this.kedai, this.category, this.name, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BigText(
              text: name,
              size: Dimenssions.font26,
            ),
            SizedBox(
              width: Dimenssions.width15,
            ),
            BigText(
              text: '|',
              size: Dimenssions.font26,
            ),
            SizedBox(
              width: Dimenssions.width15,
            ),
            SmallText(
              text: kedai,
              size: Dimenssions.font14,
            ),
          ],
        ),
        SizedBox(height: Dimenssions.height10),
        SmallText(
          text: category,
          size: Dimenssions.font14,
        ),
        SizedBox(height: Dimenssions.height10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(
              text: NumberFormat.currency(
                      locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                  .format(price),
              color: priceColor,
              size: Dimenssions.font16,
            ),
          ],
        )
      ],
    );
  }
}
