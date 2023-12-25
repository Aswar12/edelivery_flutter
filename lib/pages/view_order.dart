import 'package:edelivery_flutter/providers/transaction_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:edelivery_flutter/widgets/rating_view.dart';
import 'package:edelivery_flutter/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({Key key, this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    return Scaffold(
        backgroundColor: backgroundColor5,
        body: isCurrent
            ? ListView.builder(
                itemCount: transactionProvider.transactions.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: Dimenssions.height10,
                      left: Dimenssions.width20,
                      right: Dimenssions.width20,
                    ),
                    padding: EdgeInsets.all(Dimenssions.width10),
                    decoration: BoxDecoration(
                      color: backgroundColor1,
                      borderRadius: BorderRadius.circular(Dimenssions.width10),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#Order ID: ${transactionProvider.transactions[index].id}',
                              style: primaryTextStyle.copyWith(
                                fontSize: Dimenssions.width15,
                                fontWeight: medium,
                              ),
                            ),
                            SizedBox(
                              height: Dimenssions.height10,
                            ),
                            Text(
                              'Date: ${transactionProvider.transactions[index].createdAt.toString()}',
                              style: secondaryTextStyle.copyWith(
                                fontSize: Dimenssions.width15,
                              ),
                            ),
                            SizedBox(
                              height: Dimenssions.height10,
                            ),
                            Text(
                              'Status: ${transactionProvider.transactions[index].status}',
                              style: secondaryTextStyle.copyWith(
                                fontSize: Dimenssions.width15,
                              ),
                            ),
                            SizedBox(
                              height: Dimenssions.height10,
                            ),
                            Text(
                              'Total: ${transactionProvider.transactions[index].totalPrice}',
                              style: secondaryTextStyle.copyWith(
                                fontSize: Dimenssions.width15,
                              ),
                            ),
                            SizedBox(
                              height: Dimenssions.height10,
                            ),
                            Text(
                              'Payment: ${transactionProvider.transactions[index].payment}',
                              style: secondaryTextStyle.copyWith(
                                fontSize: Dimenssions.width15,
                              ),
                            ),
                            SizedBox(
                              height: Dimenssions.height10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            : ListView.builder(
                itemCount: transactionProvider.transactionsHistory.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: Dimenssions.height10,
                      left: Dimenssions.width20,
                      right: Dimenssions.width20,
                    ),
                    padding: EdgeInsets.all(Dimenssions.width10),
                    decoration: BoxDecoration(
                      color: backgroundColor1,
                      borderRadius: BorderRadius.circular(Dimenssions.width10),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#Order ID: ${transactionProvider.transactionsHistory[index].id}',
                              style: primaryTextStyle.copyWith(
                                fontSize: Dimenssions.width15,
                                fontWeight: medium,
                              ),
                            ),
                            SizedBox(
                              height: Dimenssions.height10,
                            ),
                            Text(
                              'Date: ${transactionProvider.transactionsHistory[index].createdAt.toString()}',
                              style: secondaryTextStyle.copyWith(
                                fontSize: Dimenssions.width15,
                              ),
                            ),
                            SizedBox(
                              height: Dimenssions.height10,
                            ),
                            Text(
                              'Status: ${transactionProvider.transactionsHistory[index].status}',
                              style: secondaryTextStyle.copyWith(
                                fontSize: Dimenssions.width15,
                              ),
                            ),
                            SizedBox(
                              height: Dimenssions.height10,
                            ),
                            Text(
                              'Total: ${transactionProvider.transactionsHistory[index].totalPrice}',
                              style: secondaryTextStyle.copyWith(
                                fontSize: Dimenssions.width15,
                              ),
                            ),
                            SizedBox(
                              height: Dimenssions.height10,
                            ),
                            Text(
                              'Payment: ${transactionProvider.transactionsHistory[index].payment}',
                              style: secondaryTextStyle.copyWith(
                                fontSize: Dimenssions.width15,
                              ),
                            ),
                            SizedBox(
                              height: Dimenssions.height10,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            openRatingDialog(
                                context,
                                transactionProvider
                                    .transactionsHistory[index].id);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: Dimenssions.width10),
                            padding: EdgeInsets.all(Dimenssions.width10 / 1.5),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(
                                  Dimenssions.radius20 / 1.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: priceColor,
                                  size: 18,
                                ),
                                const Text('Rate Us')
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ));
  }

  openRatingDialog(BuildContext context, id) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: backgroundColor1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimenssions.radius30),
            ),
            child: RatingView(transactionId: id),
          );
        });
  }
}
