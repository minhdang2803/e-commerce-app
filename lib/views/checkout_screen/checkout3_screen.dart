import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CheckoutThirdScreen extends StatefulWidget {
  const CheckoutThirdScreen({super.key});
  static const String routeName = "checkout_third";
  static CustomTransitionPage page() {
    return CustomTransitionPage<void>(
      name: routeName,
      key: const ValueKey(routeName),
      child: const CheckoutThirdScreen(),
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
  State<CheckoutThirdScreen> createState() => _CheckoutThirdScreenState();
}

class _CheckoutThirdScreenState extends State<CheckoutThirdScreen> {
  final TextEditingController _nameOnCard = TextEditingController();
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _expireDay = TextEditingController();
  final TextEditingController _cvv = TextEditingController();
  @override
  void dispose() {
    _nameOnCard.dispose();
    _cardNumber.dispose();
    _expireDay.dispose();
    _cvv.dispose();
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
          function: () => context.pop(),
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
            controller: _nameOnCard,
            title: 'Name on card',
            hintText: 'Justin Biber',
          ),
          10.verticalSpace,
          CustomTextField(
            controller: _cardNumber,
            title: 'Card Number',
            hintText: 'xxxx xxxx xxxx xxxx',
          ),
          10.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _expireDay,
                  title: 'Expiry Day',
                  hintText: '09 / 12',
                ),
              ),
              5.horizontalSpace,
              Expanded(
                child: CustomTextField(
                  controller: _cvv,
                  title: 'CVV',
                  hintText: '268 Lý Thường Kiệt',
                ),
              ),
            ],
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
                _buildDotProcess(true),
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
