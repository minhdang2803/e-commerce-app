import 'package:ecom/controllers/checkout_provider.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/utils/custom_button.dart';
import 'package:ecom/utils/custom_checkbox.dart';
import 'package:ecom/views/home_screen/account_component/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../models/checkout_feature/address_model.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});
  static const String routeName = 'AddressScreen';
  static CustomTransitionPage page() {
    return CustomTransitionPage<void>(
      name: routeName,
      key: const ValueKey(routeName),
      child: const AddressScreen(),
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
          'Address list',
          style: AppTypography.title.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: SafeArea(
          child: Column(
            children: [
              context.read<CheckoutProvider>().addressModel.isNotEmpty
                  ? _buildListView(context)
                  : _buildEmptyCart(),
              CustomButton(
                text: 'Add Address',
                color: AppColor.buttonColor,
                textColor: Colors.black,
                function: () => context.pushNamed(AddAddressScreen.routeName),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/home_screen/empty-card.svg'),
          10.verticalSpace,
          Text('No address added', style: AppTypography.title)
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Expanded(
      child: Consumer<CheckoutProvider>(
        builder: (context, value, child) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final element =
                  context.read<CheckoutProvider>().addressModel[index];
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  value.removeAddress(element);
                },
                background: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: EdgeInsets.only(right: 10.w),
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                child: AddressCard(
                  title: element.title,
                  description: element.address,
                  onChange: (value) {},
                ),
              );
            },
            separatorBuilder: (context, index) => 10.verticalSpace,
            itemCount: context.read<CheckoutProvider>().addressModel.length,
          );
        },
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.title,
    required this.description,
    required this.onChange,
  });
  final String title;
  final String description;
  final Function onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250.w,
                child: Text(
                  title,
                  style: AppTypography.title.copyWith(color: Colors.black),
                ),
              ),
              5.verticalSpace,
              SizedBox(
                width: 250.w,
                child: Text(description, style: AppTypography.body),
              )
            ],
          ),
          CustomCheckbox(onChange: onChange)
        ],
      ),
    );
  }
}

List<AddressModel> addressList = [
  AddressModel(
    address: '268 Lý Thường Kiệt, P14, Q10, TPHCM',
    title: 'Đại học Bách Khoa',
  ),
  AddressModel(
    address: '285 CMT8, P12, Q10, TPHCM',
    title: 'Tòa Nhà Viettel Complex',
  ),
  AddressModel(
    address: '231 Lê Quang Định, P7, QBT, TPHCM',
    title: 'Nhà riêng 1',
  ),
  AddressModel(
    address: '47/42/11 D1 Bùi Đình Túy, P24, QBT, TPHCM',
    title: 'Nhà riêng 2',
  )
];
