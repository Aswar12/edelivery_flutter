import 'dart:math';

import 'package:edelivery_flutter/providers/transaction_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RatingView extends StatefulWidget {
  int transactionId;
  RatingView({Key key, this.transactionId}) : super(key: key);

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  TextEditingController ratingTextController = TextEditingController(text: '');
  final _ratingPageController = PageController();
  var _starPosition = 200.0;
  var _rating = 0;
  var _ratingNote = '';
  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    _ratingNote = ratingTextController.text;
    ratingHandle() async {
      if (await transactionProvider.addRating(
        widget.transactionId,
        _ratingNote,
        _rating,
      )) {
        Navigator.pop(context);
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor1,
        borderRadius: BorderRadius.circular(Dimenssions.radius30),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Container(
            height: max(
              300,
              Dimenssions.screenHeight * 0.3,
            ),
            child: PageView(
              controller: _ratingPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
              ],
            ),
          ),
          //done button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: priceColor,
              child: MaterialButton(
                onPressed: () {
                  ratingHandle();
                },
                child: Text('Done'),
                textColor: backgroundColor1,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              child: MaterialButton(
                onPressed: () {},
                child: Text('Skip'),
                textColor: blackColor,
              ),
            ),
          ),
          AnimatedPositioned(
            top: _starPosition,
            left: 0,
            right: 0,
            duration: Duration(milliseconds: 350),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {
                    _ratingPageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                    setState(() {
                      _starPosition = 30.0;
                      _rating = index + 1;
                    });
                  },
                  icon: index < _rating
                      ? Icon(
                          Icons.star,
                          color: priceColor,
                          size: 32,
                        )
                      : Icon(
                          Icons.star_border,
                          color: priceColor,
                          size: 32,
                        ),
                  color: mainColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildThanksNote() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Thanks for your order!',
          style: primaryTextStyle.copyWith(
            fontSize: Dimenssions.width20,
            fontWeight: semiBold,
          ),
        ),
        TextField(
          controller: ratingTextController,
          decoration: InputDecoration(
            hintText: 'Tell us why you give this rating',
            hintStyle: secondaryTextStyle.copyWith(
              fontSize: Dimenssions.width15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimenssions.radius15),
            ),
          ),
        ),
      ],
    );
  }
}
