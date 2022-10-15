import 'package:flutter/material.dart';
import 'package:edelivery_flutter/models/message_model.dart';
import 'package:edelivery_flutter/models/product_model.dart';
import 'package:edelivery_flutter/pages/detail_chat_page.dart';
import 'package:edelivery_flutter/theme.dart';

class ChatTile extends StatelessWidget {
  final MessageModel message;
  // ignore: use_key_in_widget_constructors
  const ChatTile(this.message);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailChatPage(
              UninitializedProductModel(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: Dimenssions.height20),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/image_shop_logo.png',
                  width: Dimenssions.width55,
                ),
                SizedBox(
                  width: Dimenssions.width15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edelivery Food',
                        style: primaryTextStyle.copyWith(
                          fontSize: Dimenssions.font16,
                        ),
                      ),
                      Text(
                        message.message,
                        style: secondaryTextStyle.copyWith(
                          fontWeight: light,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Now',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimenssions.height15,
            ),
            const Divider(
              thickness: 1,
              color: Color(0xff2B2939),
            ),
          ],
        ),
      ),
    );
  }
}
