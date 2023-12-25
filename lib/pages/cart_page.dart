import 'package:edelivery_flutter/providers/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:edelivery_flutter/providers/cart_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:edelivery_flutter/widgets/cart_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    await Provider.of<AddressProvider>(context, listen: false)
        .getUserLocations();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Your Cart',
          style: primaryTextStyle.copyWith(
            fontWeight: medium,
          ),
        ),
        elevation: 0,
      );
    }

    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_empty_cart.png',
              width: Dimenssions.width80,
            ),
            SizedBox(
              height: Dimenssions.height20,
            ),
            Text(
              'Opss! Your Cart is Empty',
              style: primaryTextStyle.copyWith(
                fontSize: Dimenssions.font16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: Dimenssions.height15,
            ),
            Text(
              'Let\'s find your favorite shoes',
              style: secondaryTextStyle,
            ),
            Container(
              width: Dimenssions.width150,
              height: Dimenssions.height45,
              margin: EdgeInsets.only(
                top: Dimenssions.height20,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimenssions.radius20),
                  ),
                ),
                child: Text(
                  'Explore Store',
                  style: primaryTextStyle.copyWith(
                    fontSize: Dimenssions.font16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: cartProvider.carts
            .map(
              (cart) => CartCard(cart),
            )
            .toList(),
      );
    }

    Widget customBottomNav() {
      return SizedBox(
        height: Dimenssions.height180,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimenssions.width30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: primaryTextStyle,
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(cartProvider.totalPrice()),
                    style: priceTextStyle.copyWith(
                      fontSize: Dimenssions.font16,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimenssions.height30,
            ),
            Divider(
              thickness: 0.3,
              color: subtitleColor,
            ),
            SizedBox(
              height: Dimenssions.height30,
            ),
            Container(
              height: Dimenssions.height50,
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimenssions.height20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimenssions.radius15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Continue to Checkout',
                      style: primaryTextStyle.copyWith(
                        fontSize: Dimenssions.font16,
                        fontWeight: semiBold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: primaryTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: cartProvider.carts.isEmpty ? emptyCart() : content(),
      bottomNavigationBar:
          cartProvider.carts.isEmpty ? const SizedBox() : customBottomNav(),
    );
  }
}
