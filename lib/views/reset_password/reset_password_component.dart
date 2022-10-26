import 'package:ecom/controllers/reset_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../theme/app_color.dart';
import '../../utils/custom_button.dart';
import '../../utils/text_field_custom.dart';

class ResetPasswordComponent extends StatelessWidget {
  const ResetPasswordComponent({
    super.key,
    required this.email,
  });

  final TextEditingController email;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
            child: Form(
              key: context.read<ResetPasswordProvider>().forgetfForm,
              child: Column(
                children: [
                  30.verticalSpace,
                  CustomTextField(
                    title: "Email",
                    hintText: 'abc@example.com',
                    controller: email,
                  ),
                  20.verticalSpace,
                  CustomButton(
                    text: 'Reset Password',
                    color: AppColor.buttonColor,
                    textColor: AppColor.textPrimary,
                    function: () =>
                        context.read<ResetPasswordProvider>().resetPassword(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
