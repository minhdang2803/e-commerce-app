import 'package:ecom/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../controllers/register_provider.dart';
import '../../theme/app_color.dart';
import '../../utils/custom_button.dart';
import '../../utils/text_field_custom.dart';

class RegisterComponent extends StatelessWidget {
  const RegisterComponent({
    super.key,
    required this.email,
    required this.password,
    required this.username,
  });
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController password;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r)),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
            child: Form(
              key: context.read<RegisterProvider>().registerForm,
              child: ListView(
                children: [
                  30.verticalSpace,
                  CustomTextField(
                    title: "Username",
                    hintText: 'My username',
                    controller: username,
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    title: "Email",
                    hintText: 'abc@example.com',
                    controller: email,
                    validator: (value) {
                      if (value == null) {
                        return 'Please input correct Email';
                      } else if (!value.isValidEmail()) {
                        return 'Please input correct Email';
                      }
                      return null;
                    },
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    title: "Password",
                    hintText: 'Input your password',
                    isPassword: true,
                    controller: password,
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: AppColor.inputTextBorder,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please input correct Passord';
                      } else if (!value.isValidPassword()) {
                        return 'Please input correct Passord';
                      }
                      return null;
                    },
                  ),
                  20.verticalSpace,
                  CustomButton(
                    text: 'Create an account',
                    color: AppColor.buttonColor,
                    textColor: AppColor.textPrimary,
                    function: () {
                      final provider = context.read<RegisterProvider>();
                      if (provider.registerForm.currentState!.validate()) {
                        provider.registerByEmail();
                      }
                    },
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
