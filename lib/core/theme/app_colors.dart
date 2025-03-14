import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryColor = Color(0XFF12476B);
  static const Color secondaryColor = Color(0XFFFFDA7A);
  static const Color greenColor = Color(0XFF60D698);
  static const Color whiteColor = Color(0XFFFFFFFF);
  static const Color blackColor = Color(0XFF000000);
  static const Color greyColor = Color(0XFFD7D7D7);
  static const Color greyTextColor = Color(0XFF646464);
  static const Color redButtonColor = Color(0XFFFF2A2A);
  static const Color redTextColor = Color(0XFFFF1D5E);
  static const Color maroonColor = Color(0XFFC11616);
  static const Color blueColor = Color(0XFF2AA8FF);
  static const Color darkblue = Color(0xff0D4A71);
  static const Color orange = Color(0xffF57C00);

  static Color fromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHexColor(Color color) {
    return color.value.toRadixString(16);
  }
}
