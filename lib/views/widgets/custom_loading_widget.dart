import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_color.dart';

class CustomLoadingButton extends StatefulWidget {
  const CustomLoadingButton({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomLoadingButton> createState() => _CustomLoadingButtonState();
}

class _CustomLoadingButtonState extends State<CustomLoadingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.buttonColor,
      ),
      child: FittedBox(
          child: Padding(
        padding: EdgeInsets.all(10.r),
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      )),
    );
  }
}
