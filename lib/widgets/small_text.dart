import 'package:flutter/cupertino.dart';

import 'package:google_fonts/google_fonts.dart';

class SmallText extends StatelessWidget {
  final String text;
  double size;
  Color color;
  double height;

  SmallText({
    Key key,
    this.text,
    this.color = const Color(0xff504F5E),
    this.size = 12,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        height: height,
      ),
    );
  }
}
