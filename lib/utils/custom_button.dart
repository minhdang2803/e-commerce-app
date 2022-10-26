import 'package:ecom/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.function,
    this.textColor = Colors.white,
    this.icon,
    this.height,
    this.width,
    this.fontSize = 20,
  }) : super(key: key);

  final String text;
  final Color color;
  final void Function() function;
  final double? height;
  final double? width;
  final Color? textColor;
  final double? fontSize;

  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: height ?? 40.h,
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0.0),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? icon! : Container(),
            icon != null ? 5.horizontalSpace : 0.horizontalSpace,
            Text(
              text,
              style: AppTypography.title.copyWith(
                fontSize: (fontSize as double).r,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
