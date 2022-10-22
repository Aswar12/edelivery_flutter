import 'package:edelivery_flutter/models/product_model.dart';
import 'package:edelivery_flutter/models/user_model.dart';
import 'package:edelivery_flutter/providers/auth_provider.dart';
import 'package:edelivery_flutter/providers/page_provider.dart';
import 'package:edelivery_flutter/providers/product_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:edelivery_flutter/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';
  @override
  void initState() {
    searchController.addListener(
      () {
        setState(() {
          searchText = searchController.text;
        });
      },
    );
    Future.delayed(
      Duration(seconds: 3),
      (() {
        searchController.text.isEmpty
            ? Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false)
            : const SearchPage();
      }),
    );
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: Dimenssions.height20,
          left: Dimenssions.width25,
          right: Dimenssions.width25,
        ),
        child: Row(
          children: [
            Expanded(
                child: Container(
              height: Dimenssions.height40,
              child: TextField(
                onChanged: (value) =>
                    Provider.of<ProductProvider>(context, listen: false)
                        .getProductsByName(value),
                autofocus: true,
                controller: searchController,
                decoration: InputDecoration(
                  hintStyle: subtitleTextStyle.copyWith(
                    fontSize: Dimenssions.font14,
                  ),
                  contentPadding: EdgeInsets.all(Dimenssions.height10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2),
                    borderRadius: BorderRadius.circular(Dimenssions.radius15),
                  ),
                  hintText: 'Mau Makan Apa Hari Ini?',
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.black54,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2),
                    borderRadius: BorderRadius.circular(Dimenssions.radius15),
                  ),
                ),
              ),
            )),
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

    Widget body() {
      return Container(
        margin: EdgeInsets.only(top: Dimenssions.height30),
        child: searchController.text.isNotEmpty
            ? Column(
                children: productProvider.products
                    .map((product) => ProductTile(product))
                    .toList())
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Type something to search',
                      style: subtitleTextStyle.copyWith(
                        fontSize: Dimenssions.font16,
                      ),
                    ),
                  ],
                ),
              ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          header(),
          body(),
        ],
      ),
    );
  }
}
