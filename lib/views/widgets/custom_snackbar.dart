import 'package:another_flushbar/flushbar.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showSnakBar(BuildContext context, {String? message = 'error'}) {
  var flushbar = Flushbar(
    icon: SvgPicture.asset('assets/auth/snackbar_icon.svg'),
    maxWidth: MediaQuery.of(context).size.width * 0.9,
    messageText: Text(
      message!,
      style: AppTypography.title.copyWith(color: Colors.white),
    ),
    messageSize: 14.r,
    duration: const Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.BOTTOM,
    onTap: (flushbar) {},
    borderRadius: BorderRadius.circular(8.r),
    margin: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
  );
  flushbar.show(context);
}
