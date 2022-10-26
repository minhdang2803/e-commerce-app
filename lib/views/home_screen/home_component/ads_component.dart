import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../theme/app_color.dart';
import '../../../theme/app_font.dart';
import '../../../utils/custom_button.dart';

class AdsCard extends StatelessWidget {
  const AdsCard({
    super.key,
    required this.color,
    required this.title,
    required this.content,
    required this.imageUrls,
    required this.controller,
  });

  final List<String> title;
  final List<String> content;
  final List<Color> color;
  final List<String> imageUrls;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 90.h,
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                color: Colors.transparent,
                width: 320.w,
                height: 100.h,
                child: PageView(
                  controller: controller,
                  children: [
                    _buildContent(context, title[0], content[0], imageUrls[0],
                        AppColor.primaryDarker, Colors.white),
                    _buildContent(context, title[1], content[1], imageUrls[1],
                        color[1], Colors.black),
                  ],
                ),
              ),
            ),
            _buildPageIndicator(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator(BuildContext context) {
    return Positioned.fill(
      bottom: 5.h,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SmoothPageIndicator(
          controller: controller, // PageController
          count: 2,
          effect: WormEffect(
              radius: 50.r,
              dotHeight: 10,
              dotWidth: 10,
              dotColor: Colors.grey), // your preferred effect
          onDotClicked: (index) {},
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, String title, String text,
      String imageUrl, Color color, Color textColor) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 30.w, top: 15.h),
          color: color,
          width: MediaQuery.of(context).size.width * 0.50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodySmall.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              2.verticalSpace,
              Text(
                text,
                style: AppTypography.bodySmall.copyWith(
                  fontSize: 10.5,
                  fontWeight: FontWeight.normal,
                  color: textColor,
                ),
              ),
              5.verticalSpace,
              CustomButton(
                text: 'Get',
                fontSize: 10,
                textColor: Colors.black,
                color: AppColor.buttonColor,
                function: () {},
                width: 50.w,
                height: 20.h,
              )
            ],
          ),
        ),
        Container(
          width: 22.r,
          color: color,
        ),
        Image.asset(
          imageUrl,
        )
      ],
    );
  }
}
