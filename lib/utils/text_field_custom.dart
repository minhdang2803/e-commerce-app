import 'package:ecom/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.isPassword = false,
    this.suffixIcon,
    this.validator,
    this.radius,
  });
  final TextEditingController controller;
  final String hintText;
  final String title;
  bool isPassword;
  Widget? suffixIcon;
  String? Function(String?)? validator;
  double? radius;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTypography.title,
        ),
        2.verticalSpace,
        TextFormField(
          obscureText: widget.isPassword,
          enableSuggestions: false,
          autocorrect: false,
          controller: widget.controller,
          style: AppTypography.body.copyWith(decoration: TextDecoration.none),
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon != null
                ? GestureDetector(
                    child: widget.suffixIcon,
                    onLongPress: () {
                      setState(() {
                        widget.isPassword = !widget.isPassword;
                      });
                    },
                    onLongPressUp: () {
                      setState(() {
                        widget.isPassword = !widget.isPassword;
                      });
                    },
                  )
                : null,
            // border:,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 20.r),
              borderSide: BorderSide(color: AppColor.inputTextBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 20.r),
              borderSide: BorderSide(color: AppColor.inputTextBorder),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 20.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 20.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            hintText: widget.hintText,
            hintStyle: AppTypography.body.copyWith(
              color: AppColor.inputTextBorder,
            ),
          ),
          cursorColor: AppColor.inputTextBorder,
          validator: widget.validator,
        ),
      ],
    );
  }
}
