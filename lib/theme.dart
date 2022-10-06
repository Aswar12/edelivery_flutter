import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

double defaultMargin = 30.0;

Color primaryColor = const Color(0xff6C5ECF);
Color secondaryColor = const Color(0xff38ABBE);
Color alertColor = const Color(0xffED6363);
Color priceColor = const Color(0xff2C96F1);
Color backgroundColor1 = const Color(0xff1F1D2B);
Color backgroundColor2 = const Color(0xff2B2937);
Color backgroundColor3 = const Color(0xff242231);
Color backgroundColor4 = const Color(0xff252836);
Color backgroundColor5 = const Color(0xff2B2844);
Color backgroundColor6 = const Color(0xffECEDEF);
Color primaryTextColor = const Color(0xffF1F0F2);
Color secondaryTextColor = const Color(0xff999999);
Color subtitleColor = const Color(0xff504F5E);
Color transparentColor = Colors.transparent;
Color blackColor = const Color(0xff2E2E2E);

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: primaryTextColor,
);

TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: secondaryTextColor,
);

TextStyle subtitleTextStyle = GoogleFonts.poppins(
  color: subtitleColor,
);

TextStyle priceTextStyle = GoogleFonts.poppins(
  color: priceColor,
);

TextStyle purpleTextStyle = GoogleFonts.poppins(
  color: primaryColor,
);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: blackColor,
);

TextStyle alertTextStyle = GoogleFonts.poppins(
  color: alertColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

class Dimenssions {
  static double screenHeight = Get.context.height;
  static double screenWidth = Get.context.width;
  static double pageView = screenHeight / 3.13;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageTextContainer = screenHeight / 7.03;
  //dynamic height padding and margin
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;

  //dynamic width padding and margin
  static double width5 = screenHeight / 168.8;
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width25 = screenHeight / 33.64;
  static double width30 = screenHeight / 28.13;
  static double width35 = screenHeight / 23.88;
  static double width40 = screenHeight / 21.1;
  static double width45 = screenHeight / 18.76;
  static double width50 = screenHeight / 16.88;
  static double width55 = screenHeight / 15.27;

  static double font10 = screenHeight / 85.33;
  static double font14 = screenHeight / 62;
  static double font16 = screenHeight / 53.75;
  static double font18 = screenHeight / 47.78;
  static double font20 = screenHeight / 42.2;
  static double font22 = screenHeight / 37.78;
  static double font24 = screenHeight / 34.29;
  static double font26 = screenHeight / 32.46;

  //radius
  static double radius15 = screenHeight / 52.75;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

  //iconSIze

  static double iconSize24 = screenHeight / 35.16;
  static double iconSize16 = screenHeight / 52.75;
  //list view size
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;

  //popular food detail
  static double popularFoodDetailImgSize = screenHeight / 2.5;

  //bottom heightbar
  static double boottomHeightBar = screenHeight / 7.03;
}
