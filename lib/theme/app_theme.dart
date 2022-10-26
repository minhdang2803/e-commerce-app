import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColor.primary,
    ),
    scaffoldBackgroundColor: Colors.grey[100],
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(AppColor.scrollBarIndicator),
    ),
    useMaterial3: true,
  );

  static final defaultPinTheme = PinTheme(
    width: 32.r,
    height: 32.r,
    textStyle: AppTypography.body,
    decoration: BoxDecoration(
      border: Border.all(color: AppColor.pinBorder),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
