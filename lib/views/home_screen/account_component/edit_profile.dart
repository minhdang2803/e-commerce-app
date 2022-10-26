import 'package:ecom/controllers/profile_provider.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/utils/custom_button.dart';
import 'package:ecom/utils/text_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const String routeName = 'EditProfileScreen';
  static MaterialPage page() {
    return const MaterialPage(
      child: EditProfileScreen(),
      key: ValueKey(routeName),
      name: routeName,
    );
  }

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _imageURL = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _userName.dispose();
    _imageURL.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      builder: (context, child) => _buildUI(context),
    );
  }

  Scaffold _buildUI(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Edit profile',
          style: AppTypography.title.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              CustomTextField(
                radius: 30.r,
                controller: _userName,
                title: 'Username',
                hintText: 'Input new username',
              ),
              10.verticalSpace,
              CustomTextField(
                radius: 30.r,
                controller: _password,
                title: 'Password',
                hintText: 'Input new password',
              ),
              10.verticalSpace,
              CustomTextField(
                radius: 30.r,
                controller: _email,
                title: 'Email',
                hintText: 'Input new email',
              ),
              10.verticalSpace,
              CustomTextField(
                radius: 30.r,
                controller: _imageURL,
                title: 'Profile picture',
                hintText: 'New profile URL',
              ),
              Expanded(
                  child: SizedBox(
                height: 20.h,
              )),
              CustomButton(
                text: 'Update',
                color: AppColor.buttonColor,
                function: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
