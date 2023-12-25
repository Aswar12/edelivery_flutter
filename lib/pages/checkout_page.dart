import 'package:edelivery_flutter/providers/address_provider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:edelivery_flutter/providers/auth_provider.dart';
import 'package:edelivery_flutter/providers/cart_provider.dart';
import 'package:edelivery_flutter/providers/transaction_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:edelivery_flutter/widgets/checkout_card.dart';
import 'package:edelivery_flutter/widgets/loading_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;
  

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AddressProvider addressProvider = Provider.of<AddressProvider>(context);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });

      if (addressProvider.userLocations.isEmpty) {
        Navigator.pushNamed(
          context,
          '/add-address',
        );
      } else {
        if (await transactionProvider.checkout(
          authProvider.user.token,
          cartProvider.carts,
          cartProvider.totalPrice(),
          addressProvider.userLocation.last.id,
          addressProvider.userLocations.last.address,
        )) {
          cartProvider.carts = [];
          Navigator.pushNamedAndRemoveUntil(
              context, '/checkout-success', (route) => false);
        }

        setState(() {
          isLoading = false;
        });
      }
    }

    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: Text('Checkout Details', style: primaryTextStyle),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimenssions.width30,
        ),
        children: [
          // NOTE: LIST ITEMS
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Items',
                  style: primaryTextStyle.copyWith(
                    fontSize: Dimenssions.font16,
                    fontWeight: medium,
                  ),
                ),
                Column(
                  children: cartProvider.carts
                      .map(
                        (cart) => CheckoutCard(cart),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          // NOTE: ADDRESS DETAILS
          Container(
            margin: EdgeInsets.only(
              top: Dimenssions.width30,
            ),
            padding: EdgeInsets.all(Dimenssions.radius20),
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(Dimenssions.radius15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address Details',
                  style: primaryTextStyle.copyWith(
                    fontSize: Dimenssions.font16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(
                  height: Dimenssions.height15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Dimenssions.width15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Penerima',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          addressProvider.userLocation.last.customerName,
                          style: primaryTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                        SizedBox(
                          height: Dimenssions.height20,
                        ),
                        Text(
                          'Your Address',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Container(
                          width: 250,
                          child: Column(
                            children: [
                              Text(
                                addressProvider.userLocation.last.address,
                                style: subtitleTextStyle.copyWith(
                                  fontWeight: light,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimenssions.height10,
                        ),
                        Text(
                          'Your Number Phone',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          addressProvider.userLocation.last.phoneNumber,
                          overflow: TextOverflow.clip,
                          style: primaryTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // NOTE: PAYMENT SUMMARY
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            padding: EdgeInsets.all(Dimenssions.radius15),
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(Dimenssions.radius15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Summary',
                  style: primaryTextStyle.copyWith(
                    fontSize: Dimenssions.font16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(
                  height: Dimenssions.width15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Quantity',
                      style: secondaryTextStyle.copyWith(
                        fontSize: Dimenssions.width15,
                      ),
                    ),
                    Text(
                      '${cartProvider.totalItems()} Items',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimenssions.width15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Price',
                      style: secondaryTextStyle.copyWith(
                        fontSize: Dimenssions.width15,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                          .format(cartProvider.totalPrice()),
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimenssions.width15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping',
                      style: secondaryTextStyle.copyWith(
                        fontSize: Dimenssions.width15,
                      ),
                    ),
                    Text(
                      'Rp. 5000',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimenssions.width15,
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xff2E3141),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                          .format(cartProvider.totalPrice() + 5000),
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // NOTE: CHECKOUT BUTTON
          SizedBox(
            height: defaultMargin,
          ),
          const Divider(
            thickness: 1,
            color: Color(0xff2E3141),
          ),
          isLoading
              ? Container(
                  margin: const EdgeInsets.only(
                    bottom: 30,
                  ),
                  child: const LoadingButton(),
                )
              : Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: defaultMargin,
                  ),
                  child: TextButton(
                    onPressed: handleCheckout,
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimenssions.width15),
                      ),
                    ),
                    child: Text(
                      'Checkout Now',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
    );
  }
}
