import 'package:ecom/controllers/register_provider.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/views/register_screen/register_component.dart';
import 'package:ecom/views/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../controllers/base_provider.dart';
import '../../utils/show_dialog.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";
  static MaterialPage page() {
    return const MaterialPage(
      child: RegisterScreen(),
      name: routeName,
      key: ValueKey(routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
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
                  showDialogAlert(
                      context: context,
                      title: 'Alert!',
                      buttonText: 'Back to Login',
                      message: 'Please check your email and verify an account',
                      onPressed: () {
                        Navigator.pop(context);
                        context.goNamed(LoginScreen.routeName);
                      });
                  value.setStatus(ViewState.none, notify: true);
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
                        Navigator.pop(context);
                      });
                  value.setStatus(ViewState.none, notify: true);
                });
              }
              return _buildUI(context);
            },
            child: _buildUI(context));
      },
    );
  }
}

Widget _buildUI(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: true,
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
        RegisterComponent(
          email: context.read<RegisterProvider>().registerInstance.email,
          password: context.read<RegisterProvider>().registerInstance.password,
          username: context.read<RegisterProvider>().registerInstance.username,
        )
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
            'Create your account',
            style: AppTypography.title.copyWith(color: Colors.white),
          ),
          5.verticalSpace,
          GestureDetector(
            onTap: () => context.pop(),
            child: RichText(text: TextSpan(children: [..._buildTextSpan()])),
          )
        ],
      ),
    ),
  );
}

List<TextSpan> _buildTextSpan() {
  String welcomeText = 'Do you already have account ? Sign In';
  List<TextSpan> result = [];
  List<String> listOfText = welcomeText.split(' ');
  for (final element in listOfText) {
    if (['Sign', 'In'].contains(element)) {
      result.add(
        TextSpan(
          text: ' $element',
          style: AppTypography.bodySmall.copyWith(color: AppColor.buttonColor),
        ),
      );
    } else if (element == 'Please') {
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
