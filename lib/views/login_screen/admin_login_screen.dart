import 'package:ecom/controllers/admin_controller/admin_cubit.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/views/home_screen/admin_home_screen.dart';
import 'package:ecom/views/login_screen/admin_login_component.dart';
import 'package:ecom/views/widgets/custom_snackbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});
  static const String routeName = "AdminScreen";
  static MaterialPage page() {
    return const MaterialPage(
      child: AdminLoginScreen(),
      name: routeName,
      key: ValueKey(routeName),
    );
  }

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _loginEmail = TextEditingController();

  final TextEditingController _loginPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AdminFail) {
          showSnakBar(context, message: state.error);
        }
        if (state is AdminSuccess) {
          context.goNamed(AdminHomeScreen.routeName);
        }
      },
      child: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.primary,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: SvgPicture.asset('assets/auth/login_oval.svg'),
          ),
          _buildBackButton(context),
          _buildWelcomeText(context),
          AdminLoginComponent(email: _loginEmail, password: _loginPassword)
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 30.h,
      left: 10.w,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => context.pop(),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return Positioned(
      top: 70.h,
      left: 20.w,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login for adminstrator',
              style: AppTypography.title.copyWith(color: Colors.white),
            ),
            5.verticalSpace,
            Text(
              'Please login user your admin account',
              style: AppTypography.bodySmall.copyWith(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
