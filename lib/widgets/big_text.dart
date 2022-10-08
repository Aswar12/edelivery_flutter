import 'package:edelivery_flutter/theme.dart';
import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final String text;
  double size;
  Color color;
  TextOverflow overFlow;
  BigText({
    Key key,
    this.text,
    this.color = const Color(0xff332d2b),
    this.size = 20,
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontSize: Dimenssions.font20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
