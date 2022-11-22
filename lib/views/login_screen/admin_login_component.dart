import 'package:ecom/controllers/admin_controller/admin_cubit.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';
import '../widgets/custom_loading_widget.dart';

class AdminLoginComponent extends StatefulWidget {
  const AdminLoginComponent(
      {super.key, required this.email, required this.password});
  final TextEditingController email;
  final TextEditingController password;

  @override
  State<AdminLoginComponent> createState() => _AdminLoginComponentState();
}

class _AdminLoginComponentState extends State<AdminLoginComponent> {
  @override
  void dispose() {
    widget.email.dispose();
    widget.password.dispose();
    super.dispose();
  }

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
              key: context.read<AdminCubit>().form,
              child: Column(
                children: [
                  30.verticalSpace,
                  CustomTextField(
                    title: "Email",
                    hintText: 'abc@example.com',
                    controller: widget.email,
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
                    controller: widget.password,
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: AppColor.inputTextBorder,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please input correct Passord';
                      }
                      return null;
                    },
                  ),
                  20.verticalSpace,
                  _buildLoginButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
      if (state is AdminLoading) {
        return const CustomLoadingButton();
      }
      return CustomButton(
        text: 'Sign In',
        color: AppColor.buttonColor,
        textColor: AppColor.textPrimary,
        function: () {
          if (context.read<AdminCubit>().form.currentState!.validate()) {
            context.read<AdminCubit>().loginAdmin(
                  widget.email.text,
                  widget.password.text,
                );
          }
        },
      );
    });
  }
}
