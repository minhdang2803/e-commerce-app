import 'package:ecom/controllers/home_provider.dart';
import 'package:ecom/models/home_screen/product_component/ecom_product_model.dart';
import 'package:ecom/models/home_screen/product_component/goods_model.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/views/home_screen/home_component/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../theme/app_color.dart';
import '../utils/custom_button.dart';
import '../views/checkout_screen/order_list_component.dart';
import 'vnpay.dart';

class PaymentInfoScreen extends StatefulWidget {
  const PaymentInfoScreen({Key? key}) : super(key: key);
  static const routeName = 'PaymentInfo';
  static CustomTransitionPage page() {
    return CustomTransitionPage<void>(
      name: routeName,
      key: const ValueKey(routeName),
      child: const PaymentInfoScreen(),
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
  State<PaymentInfoScreen> createState() => PaymentInfoScreenState();
}

class PaymentInfoScreenState extends State<PaymentInfoScreen> {
  final TextEditingController amountController = TextEditingController();
  bool isDropdown = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _buildOrderList(context),
            _buildAddress(context),
            _buildPayment(context),
            _buildCustomButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton(BuildContext context) {
    final provider = context.read<HomeProvider>();
    return Positioned.fill(
      bottom: 20.h,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton(
              width: MediaQuery.of(context).size.width * 0.45,
              text: 'BACK',
              color: Colors.white,
              textColor: Colors.black,
              function: () => Navigator.pop(context),
            ),
            CustomButton(
              width: MediaQuery.of(context).size.width * 0.45,
              text: 'NEXT',
              color: AppColor.buttonColor,
              textColor: Colors.black,
              function: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    final value = (provider.getTotalPrice()).toInt();

                    return MyHomePage(
                      title: 'Payment',
                      value.toString(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Positioned.fill(
      top: 250.h,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.all(20.r),
          color: Colors.white,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping Address',
                style: AppTypography.body.copyWith(color: Colors.black),
              ),
              SizedBox(
                width: 250.w,
                child: Text(
                  '268 Lý Thường Kiệt, Phường 14, Quận 10, Thành phố Hồ Chí Minh',
                  style: AppTypography.bodySmall,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPayment(BuildContext context) {
    return Positioned.fill(
      top: 350.h,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(20.r),
          color: Colors.white,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment',
                style: AppTypography.body.copyWith(color: Colors.black),
              ),
              5.verticalSpace,
              Row(
                children: [
                  Image.asset(
                    'assets/home_screen/visa.png',
                    height: 40.h,
                    width: 40.h,
                  ),
                  20.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Visa',
                        style: AppTypography.body.copyWith(color: Colors.black),
                      ),
                      Text(
                        '**** **** **** 1234',
                        style: AppTypography.bodySmall
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context) {
    final provider = context.read<HomeProvider>();
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order list',
                    style: AppTypography.body.copyWith(color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () => setState(() => isDropdown = !isDropdown),
                    icon: !isDropdown
                        ? const Icon(Icons.arrow_drop_up_outlined)
                        : const Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
            Visibility(
              visible: isDropdown,
              child: SizedBox(
                height: provider.cart.isEmpty ? 0 : 200.h,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final current = provider.cart.elementAt(index);
                    return GestureDetector(
                        onTap: () {
                          context.goNamed(
                            ProductItem.routeName,
                            extra: <String, Object>{'item': current},
                            params: <String, String>{
                              'name': current.productName.split(' ').join(),
                            },
                          );
                        },
                        child: ProductDropdown(itemModel: current));
                  },
                  itemCount: provider.cart.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
