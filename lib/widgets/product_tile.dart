import 'package:flutter/material.dart';
import 'package:edelivery_flutter/models/product_model.dart';
import 'package:edelivery_flutter/pages/product_page.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:intl/intl.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  // ignore: use_key_in_widget_constructors
  const ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: Dimenssions.height25,
          right: Dimenssions.height25,
          bottom: Dimenssions.height25,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.galleries[0].url,
                width: Dimenssions.height80,
                height: Dimenssions.height80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        product.category.name,
                        style: secondaryTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        width: Dimenssions.width10,
                      ),
                      Text(
                        '|',
                        style: primaryTextStyle.copyWith(
                          fontSize: Dimenssions.font16,
                        ),
                      ),
                      SizedBox(
                        width: Dimenssions.width10,
                      ),
                      Text(
                        product.kedai.name,
                        style: secondaryTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    product.name,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(product.price),
                    style: priceTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
