import 'package:flutter/material.dart';

extension ColorExtension on Color {
  static Color hexToColor(String hexValue) {
    hexValue = hexValue.replaceAll('#', '');
    if (hexValue.length == 6) {
      hexValue = "FF$hexValue";
    }
    return Color(int.parse(hexValue, radix: 16));
  }
}
