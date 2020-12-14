import 'package:flutter/material.dart';

class HtmlColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HtmlColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
