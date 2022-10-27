import 'package:ecom/controllers/controllers.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/utils/custom_button.dart';
import 'package:ecom/utils/text_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../models/checkout_feature/address_model.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});
  static const String routeName = "AddAddressScreen";
  static CustomTransitionPage page() {
    return CustomTransitionPage<void>(
      name: routeName,
      key: const ValueKey(routeName),
      child: const AddAddressScreen(),
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
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();
  @override
  void dispose() {
    _address.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adding address',
          style: AppTypography.title.copyWith(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                CustomTextField(
                  controller: _name,
                  title: "Name of address",
                  hintText: 'Home',
                ),
                5.verticalSpace,
                CustomTextField(
                  controller: _address,
                  title: 'Address',
                  hintText: '268 Lý Thường Kiệt',
                ),
              ],
            ),
          ),
          CustomButton(
            text: 'Add address',
            color: AppColor.buttonColor,
            function: () {
              Provider.of<CheckoutProvider>(context, listen: false).addAddress(
                AddressModel(title: _name.text, address: _address.text),
              );
              context.pop();
            },
          )
        ],
      )),
    );
  }
}
