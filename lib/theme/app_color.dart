import 'package:ecom/extension/color_extension.dart';
import 'package:flutter/material.dart';

class AppColor {
  //main colors
  static Color primary = ColorExtension.hexToColor('#0063C6');
  static Color buttonColor = ColorExtension.hexToColor('#FFC33A');
  static Color primaryDarker = ColorExtension.hexToColor('#025AB4');
  static Color adsColor = ColorExtension.hexToColor('#286BC7');

  static Color textTitle = Colors.black;
  static Color textPrimary = ColorExtension.hexToColor('#5F5F5F');
  static Color textSecondary = ColorExtension.hexToColor('#B8BFC5');

  static Color appBackground = Colors.white;

  //scroll bar indicator color
  static Color scrollBarIndicator = Color(0xFF7B7B7B);

  //pin border color (sms pin code)
  static Color pinBorder = Color(0xFF7B7B7B);

  //Icon border color
  static Color iconBorder = Color(0xFFF3F3F3);

  //input text field border color
  static Color inputTextBorder = ColorExtension.hexToColor('#DCDCDC');

  //default border color
  static Color defaultBorder = Color(0xFFE3E3E3);
}
