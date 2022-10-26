import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/utils/custom_checkbox.dart';
import 'package:ecom/utils/utils.dart';
import 'package:ecom/views/checkout_screen/checkout2_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CheckoutFirstScreen extends StatelessWidget {
  const CheckoutFirstScreen({super.key});
  static const String routeName = "checkout_first";
  static CustomTransitionPage page() {
    return CustomTransitionPage<void>(
      name: routeName,
      key: const ValueKey(routeName),
      child: const CheckoutFirstScreen(),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) =>
          SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(-1.0, 0),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.linear),
          ),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: AppTypography.title.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            40.verticalSpace,
            _buildMapProcess(context),
            40.verticalSpace,
            _buildOpions(context),
            180.verticalSpace,
            CustomButton(
              text: 'NEXT',
              color: AppColor.buttonColor,
              function: () {
                context.pushNamed(CheckoutSecondScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOpions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          const OptionCard(
            title: 'Regular Delivery',
            description: 'Order will be delivered between 3 - 5 business days',
          ),
          10.verticalSpace,
          const OptionCard(
            title: 'Express Delivery',
            description:
                'Place your order before 6 pm and your items will be delivered',
          )
        ],
      ),
    );
  }

  Widget _buildMapProcess(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDotProcess(true),
                const Expanded(child: Divider(color: Colors.black)),
                _buildDotProcess(false),
                const Expanded(child: Divider(color: Colors.black)),
                _buildDotProcess(false),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery',
                style: AppTypography.body,
              ),
              Text(
                'Address',
                style: AppTypography.body,
              ),
              Text(
                'Payment',
                style: AppTypography.body,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDotProcess(bool isTrue) {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
              color: isTrue ? AppColor.buttonColor : AppColor.inputTextBorder)),
      child: isTrue
          ? Icon(
              Icons.circle,
              color: AppColor.buttonColor,
              size: 30,
            )
          : null,
    );
  }
}

class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.title,
    required this.description,
    this.width,
    this.height,
  });

  final String title;
  final String description;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 100.h,
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTypography.body.copyWith(color: Colors.black),
                ),
                5.verticalSpace,
                SizedBox(
                  width: width != null
                      ? width! * 0.7
                      : MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    description,
                    style: AppTypography.bodySmall.copyWith(color: Colors.grey),
                  ),
                ),
              ],
            ),
            CustomCheckbox(onChange: (value) {})
          ],
        ),
      ),
    );
  }
}
