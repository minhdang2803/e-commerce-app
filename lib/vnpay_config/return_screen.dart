import 'package:ecom/controllers/controllers.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/utils/utils.dart';
import 'package:ecom/views/home_screen/home_component/home_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ReturnScreen extends StatelessWidget {
  final String result;
  ReturnScreen(this.result) : super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(result)),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: _buildEmptyCart(context),
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/home_screen/done.svg'),
          10.verticalSpace,
          Text('Nothing in cart', style: AppTypography.title),
          10.verticalSpace,
          CustomButton(
            width: 200.w,
            text: 'BACK TO HOME',
            color: AppColor.buttonColor,
            function: () {
              Navigator.pop(context);
              Navigator.pop(context);
              final provider = context.read<HomeProvider>();
              context.read<HomeProvider>().addHistory(provider.cart.toList(), provider.numberOfItem);
              context.read<HomeProvider>().clearCart();
              context.goNamed(HomeComponent.routeName);
            },
          )
        ],
      ),
    );
  }
}
