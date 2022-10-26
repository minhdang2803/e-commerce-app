import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/views/home_screen/home_component/home_component.dart';

import 'package:ecom/views/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../controllers/controllers.dart';
import '../../utils/show_dialog.dart';
import 'login_component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "LoginScreen";
  static MaterialPage page() {
    return const MaterialPage(
      child: LoginScreen(),
      name: routeName,
      key: ValueKey(routeName),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginEmail = TextEditingController();

  final TextEditingController _loginPassword = TextEditingController();
  // @override
  // void dispose() {
  //   _loginEmail.dispose();
  //   _loginPassword.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
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
              context.goNamed(HomeComponent.routeName);
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
        child: _buildUI(context));
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
          LoginComponent(email: _loginEmail, password: _loginPassword)
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
              'Welcome to Login',
              style: AppTypography.title.copyWith(color: Colors.white),
            ),
            5.verticalSpace,
            GestureDetector(
              onTap: () => context.pushNamed(RegisterScreen.routeName),
              child: RichText(text: TextSpan(children: [..._buildTextSpan()])),
            )
          ],
        ),
      ),
    );
  }

  List<TextSpan> _buildTextSpan() {
    String welcomeText =
        'Please fill E-mail & password to login your app account. Sign Up';
    List<TextSpan> result = [];
    List<String> listOfText = welcomeText.split(' ');
    for (final element in listOfText) {
      if (['Sign', 'Up'].contains(element)) {
        result.add(
          TextSpan(
            text: ' $element',
            style:
                AppTypography.bodySmall.copyWith(color: AppColor.buttonColor),
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
}
