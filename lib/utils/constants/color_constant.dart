import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color primaryColor = fromHex('21a5ff');
  static Color redErrorText = fromHex('FF0000');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
