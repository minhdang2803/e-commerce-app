import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/utils/utils.dart';
import 'package:ecom/views/checkout_screen/checkout3_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CheckoutSecondScreen extends StatefulWidget {
  const CheckoutSecondScreen({super.key});
  static const String routeName = "checkout_second";
  static CustomTransitionPage page() {
    return CustomTransitionPage<void>(
      name: routeName,
      key: const ValueKey(routeName),
      child: const CheckoutSecondScreen(),
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
  State<CheckoutSecondScreen> createState() => _CheckoutSecondScreenState();
}

class _CheckoutSecondScreenState extends State<CheckoutSecondScreen> {
  final TextEditingController _streetOne = TextEditingController();
  final TextEditingController _streetTwo = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _province = TextEditingController();
  @override
  void dispose() {
    _streetOne.dispose();
    _streetTwo.dispose();
    _city.dispose();
    _country.dispose();
    _province.dispose();
    super.dispose();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              40.verticalSpace,
              _buildMapProcess(context),
              20.verticalSpace,
              _buildTextFields(context),
              20.verticalSpace,
              _buildCustomButton(context),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomButton(
          width: MediaQuery.of(context).size.width * 0.45,
          text: 'BACK',
          color: Colors.white,
          textColor: Colors.black,
          function: () => context.pop(),
        ),
        CustomButton(
          width: MediaQuery.of(context).size.width * 0.45,
          text: 'NEXT',
          color: AppColor.buttonColor,
          textColor: Colors.black,
          function: () => context.pushNamed(CheckoutThirdScreen.routeName),
        ),
      ],
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          CustomTextField(
            controller: _streetOne,
            title: 'Street one',
            hintText: '268 Lý Thường Kiệt',
          ),
          10.verticalSpace,
          CustomTextField(
            controller: _streetTwo,
            title: 'Street two',
            hintText: '285 Cách Mạng Tháng Tám',
          ),
          10.verticalSpace,
          CustomTextField(
            controller: _country,
            title: 'Country',
            hintText: 'Viet Nam',
          ),
          10.verticalSpace,
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _province,
                    title: 'Ward',
                    hintText: 'Ward 10',
                  ),
                ),
                5.horizontalSpace,
                Expanded(
                  child: CustomTextField(
                    controller: _city,
                    title: 'City/State',
                    hintText: 'Ho Chi Minh City',
                  ),
                ),
              ],
            ),
          ),
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
                _buildDotProcess(true),
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
