import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_color.dart';
import '../../theme/app_font.dart';

class OnboardingScreenComponent extends StatelessWidget {
  final String image;
  final Map<String, String> text;
  const OnboardingScreenComponent(
      {super.key, required this.image, required this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          image,
          height: 200.h,
          width: 150.w,
        ),
        50.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Text(
                text['title']!,
                style: AppTypography.headline.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              10.verticalSpace,
              Text(
                text['sub']!,
                style: AppTypography.body.copyWith(
                  color: AppColor.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}