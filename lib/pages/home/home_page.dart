import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:edelivery_flutter/models/product_model.dart';
import 'package:edelivery_flutter/pages/app_column.dart';
import 'package:edelivery_flutter/pages/product_page.dart';
import 'package:edelivery_flutter/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edelivery_flutter/models/user_model.dart';
import 'package:edelivery_flutter/providers/auth_provider.dart';
import 'package:edelivery_flutter/providers/product_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:edelivery_flutter/widgets/product_card.dart';
import 'package:edelivery_flutter/widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimenssions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    getInit();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page;
      });
    });
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    TextEditingController searchController = TextEditingController();

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: Dimenssions.height25,
          left: Dimenssions.width20,
          right: Dimenssions.width25,
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Container(
                    height: Dimenssions.height40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(Dimenssions.radius15),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.search_outlined,
                          color: Colors.black45,
                        ),
                        SizedBox(
                          width: Dimenssions.width10,
                        ),
                        Text(
                          'Mau Makan Apa Hari Ini?',
                          style: subtitleTextStyle.copyWith(
                            fontSize: Dimenssions.font14,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageProvider.currentIndex = 3;
                });
              },
              child: Container(
                width: Dimenssions.width55,
                height: Dimenssions.width55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      user.profilePhotoUrl,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget popularProductsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: Dimenssions.height20,
          left: Dimenssions.width30,
          right: Dimenssions.width30,
          bottom: Dimenssions.height10,
        ),
        child: Text(
          'Popular Foods',
          style: primaryTextStyle.copyWith(
            fontSize: Dimenssions.font22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget popularProducts() {
      return Column(
        children: [
          Container(
            height: Dimenssions.pageView,
            child: PageView.builder(
              itemCount: productProvider.products.length,
              controller: pageController,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              },
            ),
          ),
          DotsIndicator(
            dotsCount: productProvider.products.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeColor: mainColor,
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ],
      );
    }

    Widget newArrivalsTitle() {
      return Container(
        margin: EdgeInsets.only(
          left: Dimenssions.width30,
          right: Dimenssions.width30,
        ),
        child: Text(
          'New Foods',
          style: primaryTextStyle.copyWith(
            fontSize: Dimenssions.font22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget newArrivals() {
      return Container(
        margin: EdgeInsets.only(
          top: Dimenssions.height15,
        ),
        child: Column(
          children: productProvider.products
              .map(
                (product) => ProductTile(product),
              )
              .toList(),
        ),
      );
    }

    return ListView(
      children: [
        header(),
        // categories(),
        popularProductsTitle(),
        popularProducts(),
        newArrivalsTitle(),
        newArrivals(),
      ],
    );
  }

  _buildPageItem(
    int index,
  ) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    ProductModel product = productProvider.products[index];
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product),
          ),
        );
      },
      child: Transform(
        transform: matrix,
        child: Stack(
          children: [
            Container(
              height: Dimenssions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimenssions.width10, right: Dimenssions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenssions.radius30),
                  color: index.isEven
                      ? const Color(0xff69c5df)
                      : const Color(0xff9294cc),
                  image: DecorationImage(
                    image: NetworkImage(
                        productProvider.products[index].galleries[0].url),
                    fit: BoxFit.cover,
                  )),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Dimenssions.pageTextContainer,
                  margin: EdgeInsets.only(
                      left: Dimenssions.width30,
                      right: Dimenssions.width30,
                      bottom: Dimenssions.height30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimenssions.radius20),
                      color: Colors.white,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                            color: Color(0xffe8e8e8),
                            blurRadius: 5.0,
                            offset: Offset(5, 5)),
                        const BoxShadow(
                            color: Colors.white, offset: Offset(-5, 0)),
                        const BoxShadow(
                            color: Colors.white, offset: Offset(5, 0))
                      ]),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimenssions.height15,
                        left: Dimenssions.width15,
                        right: Dimenssions.width15),
                    child: AppColumn(
                      name: product.name,
                      price: product.price,
                      kedai: product.kedai.name,
                      category: product.category.name,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
