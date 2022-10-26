import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = 'SplashScreen';
  static MaterialPage page() {
    return const MaterialPage(
      child: SplashScreen(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Stack(
        children: [
          Positioned(
            right: 0,
            child: Container(
              width: 150.r,
              height: 150.r,
              decoration: BoxDecoration(
                color: AppColor.primaryDarker,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(100.r)),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 150.r,
              height: 150.r,
              decoration: BoxDecoration(
                color: AppColor.primaryDarker,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100.r),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 150.w,
              height: 70.r,
              decoration: BoxDecoration(
                  color: AppColor.buttonColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.r),
                      bottomLeft: Radius.circular(30.r))),
              child: Center(
                child: Text('E-Com',
                    style: AppTypography.headline.copyWith(fontSize: 45)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
