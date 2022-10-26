import 'package:ecom/controllers/login_provider.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/views/reset_password/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../theme/app_font.dart';
import '../../utils/utils.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent(
      {super.key, required this.email, required this.password});
  final TextEditingController email;
  final TextEditingController password;

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
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
              key: Provider.of<LoginProvider>(context, listen: false).formKey,
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
                      } else if (!value.isValidPassword()) {
                        return 'Please input correct Passord';
                      }
                      return null;
                    },
                  ),
                  5.verticalSpace,
                  _buildOptions(context),
                  20.verticalSpace,
                  CustomButton(
                    text: 'Sign In',
                    color: AppColor.buttonColor,
                    textColor: AppColor.textPrimary,
                    function: () {
                      if (context
                          .read<LoginProvider>()
                          .formKey
                          .currentState!
                          .validate()) {
                        Provider.of<LoginProvider>(context, listen: false)
                            .loginbyEmail(
                          email: widget.email.text,
                          password: widget.password.text,
                        );
                      }
                    },
                  ),
                  20.verticalSpace,
                  CustomButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.white,
                    ),
                    text: 'Login with Facebook',
                    color: AppColor.primary,
                    function: () {},
                  ),
                  20.verticalSpace,
                  CustomButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    text: 'Login with Google',
                    color: Colors.red.shade300,
                    textColor: Colors.white,
                    function: () =>
                        Provider.of<LoginProvider>(context, listen: false)
                            .loginbyGoogle(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          'Forgot password?',
          style: AppTypography.body,
        ),
        onPressed: () => context.pushNamed(ResetPassword.routeName),
      ),
    );
  }
}
