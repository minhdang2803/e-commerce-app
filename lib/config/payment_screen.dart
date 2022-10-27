import 'package:ecom/controllers/home_provider.dart';
import 'package:ecom/models/home_screen/product_component/product_model.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../theme/app_color.dart';
import '../utils/custom_button.dart';
import 'vnpay.dart';

class PaymentInfo extends StatefulWidget {
  const PaymentInfo({Key? key}) : super(key: key);
  static const routeName = 'PaymentInfo';
  static CustomTransitionPage page() {
    return CustomTransitionPage<void>(
      name: routeName,
      key: const ValueKey(routeName),
      child: const PaymentInfo(),
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
  State<PaymentInfo> createState() => PaymentInfoState();
}

class PaymentInfoState extends State<PaymentInfo> {
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
                    final value = (provider.getTotalPrice() * 24845).toInt();

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
                    return ProductDropdown(itemModel: current);
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

class ProductDropdown extends StatelessWidget {
  const ProductDropdown({super.key, required this.itemModel});
  final ProductItemModel itemModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          10.horizontalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.asset(
              itemModel.imageURL,
              width: 100.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(itemModel.name, style: AppTypography.body),
                ),
                Text('\$${itemModel.price}', style: AppTypography.body),
                _buildQuantity(context, itemModel)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantity(BuildContext context, ProductItemModel item) {
    return Row(
      children: [
        Text(
          "Total: ${context.watch<HomeProvider>().numberOfItem[item.id]!}",
          style: AppTypography.body,
        ),
      ],
    );
  }
}
