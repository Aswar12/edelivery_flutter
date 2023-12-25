import 'package:edelivery_flutter/pages/add_address_page.dart';
import 'package:edelivery_flutter/pages/pick_address_map.dart';
import 'package:edelivery_flutter/pages/search_page.dart';
import 'package:edelivery_flutter/pages/view_order_page.dart';
import 'package:edelivery_flutter/providers/address_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:edelivery_flutter/pages/cart_page.dart';
import 'package:edelivery_flutter/pages/checkout_page.dart';
import 'package:edelivery_flutter/pages/checkout_success_page.dart';
import 'package:edelivery_flutter/pages/edit_profile_page.dart';
import 'package:edelivery_flutter/pages/home/main_page.dart';
import 'package:edelivery_flutter/pages/sign_in_page.dart';
import 'package:edelivery_flutter/pages/sign_up_page.dart';
import 'package:edelivery_flutter/pages/splash_page.dart';
import 'package:edelivery_flutter/providers/auth_provider.dart';
import 'package:edelivery_flutter/providers/cart_provider.dart';
import 'package:edelivery_flutter/providers/page_provider.dart';
import 'package:edelivery_flutter/providers/product_provider.dart';
import 'package:edelivery_flutter/providers/transaction_provider.dart';
import 'package:edelivery_flutter/providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUser = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddressProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/home': (context) => const MainPage(),
          '/edit-profile': (context) => const EditProfilePage(),
          '/cart': (context) => const CartPage(),
          '/checkout': (context) => const CheckoutPage(),
          '/checkout-success': (context) => const CheckoutSuccessPage(),
          '/add-address': (context) => const AddAddressPage(),
          '/search': (context) => const SearchPage(),
          '/pick-address': (context) => const PickAddressMap(),
          '/your-order': (context) => const ViewOrderPage(),
        },
      ),
    );
  }
}
