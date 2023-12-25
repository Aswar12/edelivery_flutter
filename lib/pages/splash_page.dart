import 'package:edelivery_flutter/providers/address_provider.dart';
import 'package:edelivery_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:edelivery_flutter/providers/product_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isAuth = false;
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 4),
      (() {
        getInit();
      }),
    );

    super.initState();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    if (prefs.getString('token') != null) {
      authProvider.autologin();
      Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, '/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Lottie.network(
            'https://assets4.lottiefiles.com/packages/lf20_6sxyjyjj.json'),
      ),
    );
  }
}
