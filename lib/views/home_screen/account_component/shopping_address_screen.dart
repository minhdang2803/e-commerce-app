import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/utils/custom_button.dart';
import 'package:ecom/utils/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final element = addressList[index];
                    return AddressCard(
                      title: element.title,
                      description: element.description,
                      onChange: (value) {},
                    );
                  },
                  separatorBuilder: (context, index) => 10.verticalSpace,
                  itemCount: addressList.length,
                ),
              ),
              CustomButton(
                text: 'Add Address',
                color: AppColor.buttonColor,
                textColor: Colors.black,
                function: () {},
              )
            ],
          ),
        ),
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
    title: '268 Lý Thường Kiệt, P14, Q10, TPHCM',
    description: 'Đại học Bách Khoa',
  ),
  AddressModel(
    title: '285 CMT8, P12, Q10, TPHCM',
    description: 'Tòa Nhà Viettel Complex',
  ),
  AddressModel(
    title: '231 Lê Quang Định, P7, QBT, TPHCM',
    description: 'Nhà riêng 1',
  ),
  AddressModel(
    title: '47/42/11 D1 Bùi Đình Túy, P24, QBT, TPHCM',
    description: 'Nhà riêng 2',
  )
];

class AddressModel {
  final String title;
  final String description;
  AddressModel({required this.title, required this.description});
}
