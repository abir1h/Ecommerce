import 'package:flutter/material.dart';

class ColorHelper {
  static Color getColorFromColorCode(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
