import 'package:ecom/controllers/register_provider.dart';
import 'package:ecom/controllers/reset_provider.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';

import 'package:ecom/views/reset_password/reset_password_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../controllers/base_provider.dart';
import '../../utils/show_dialog.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});
  static const String routeName = "ResetPassword";
  static MaterialPage page() {
    return const MaterialPage(
      child: ResetPassword(),
      name: routeName,
      key: ValueKey(routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ResetPasswordProvider(),
      builder: (context, child) {
        return Consumer<RegisterProvider>(
          builder: (context, value, child) {
            if (value.viewState == ViewState.loading) {
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  showDialog(
                    context: context,
                    builder: (context) => WillPopScope(
                      onWillPop: () async {
                        value.isPop = true;
                        value.isCancel = true;
                        return true;
                      },
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (value.viewState == ViewState.done) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                context.pop();
              });
            } else if (value.viewState == ViewState.fail) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                !value.isPop ? Navigator.pop(context, true) : null;
                showDialogAlert(
                    context: context,
                    title: 'Alert!',
                    buttonText: 'Got it!',
                    message: value.errorMessage,
                    onPressed: () {
                      Navigator.pop(context, true);
                    });
                value.setStatus(ViewState.none);
              });
            }
            return _buildUI(context);
          },
          child: _buildUI(context),
        );
      },
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

  Widget _buildUI(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset('assets/auth/login_oval.svg'),
            ),
            _buildBackButton(context),
            _buildWelcomeText(context),
            ResetPasswordComponent(
              email: context.read<ResetPasswordProvider>().instance.email,
            ),
          ],
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
              'Reset Password',
              style: AppTypography.title.copyWith(color: Colors.white),
            ),
            5.verticalSpace,
            RichText(text: TextSpan(children: [..._buildTextSpan()]))
          ],
        ),
      ),
    );
  }

  List<TextSpan> _buildTextSpan() {
    String welcomeText =
        'Enter your email addreess and we will send you link to reset password';
    List<TextSpan> result = [];
    List<String> listOfText = welcomeText.split(' ');
    for (final element in listOfText) {
      if (element == 'Enter') {
        result.add(
          TextSpan(
            text: element,
            style: AppTypography.bodySmall.copyWith(color: Colors.white),
          ),
        );
      } else {
        result.add(
          TextSpan(
            text: ' $element',
            style: AppTypography.bodySmall.copyWith(color: Colors.white),
          ),
        );
      }
    }
    return result;
  }
}
