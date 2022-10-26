import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/views/login_screen/login_screen.dart';
import 'package:ecom/views/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_component.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final controller = PageController();
  static const String routeName = 'OnboardingScreen';
  static MaterialPage page() {
    return MaterialPage(
      child: OnboardingScreen(),
      name: routeName,
      key: const ValueKey(routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              20.verticalSpace,
              _buildPicture(context),
              10.verticalSpace,
              _buildPageIndicator(),
              60.verticalSpace,
              _buildOptions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPicture(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 380.h,
        child: PageView(
          controller: controller,
          children: [
            for (final element in text)
              OnboardingScreenComponent(
                image: element['url'] as String,
                text: {
                  'title': element['title'] as String,
                  'sub': element['sub'] as String
                },
              )
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return SmoothPageIndicator(
      controller: controller, // PageController
      count: 3,
      effect: WormEffect(radius: 10.r), // your preferred effect
      onDotClicked: (index) {},
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildButton(
          text: 'Sign In',
          color: AppColor.buttonColor,
          context: context,
          function: () => context.pushNamed(LoginScreen.routeName),
        ),
        10.verticalSpace,
        _buildButton(
          text: 'Sign Up',
          color: Colors.white,
          context: context,
          function: () => context.pushNamed(RegisterScreen.routeName),
        ),
      ],
    );
  }

  Widget _buildButton(
      {required String text,
      required Color color,
      required BuildContext context,
      required void Function() function}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 40.h,
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0.0),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ))),
        child: Text(
          text,
          style: AppTypography.title.copyWith(fontSize: 20.r),
        ),
      ),
    );
  }
}

List<Map<String, String>> text = [
  {
    'url': 'assets/onboarding_screen/onboarding_1.svg',
    'title': 'ORIGINAL PRODUCT',
    'sub':
        'Original with 1000 product from a lot of  different brand accros the world. buy so easy with just simple step then your item will send it.'
  },
  {
    'url': 'assets/onboarding_screen/onboarding_2.svg',
    'title': 'FREE SHIPPING',
    'sub':
        'Many of the chain transit units support, when you need, we fully support your need.'
  },
  {
    'url': 'assets/onboarding_screen/onboarding_3.svg',
    'title': 'FAST DELIVERY',
    'sub':
        'On time is our priority criteria for serving our customer. Believe us'
  },
];
