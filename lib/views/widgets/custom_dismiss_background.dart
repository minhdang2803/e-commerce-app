import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDismissBackground extends StatefulWidget {
  const CustomDismissBackground({super.key, this.isSecondary = false});
  final bool? isSecondary;

  @override
  State<CustomDismissBackground> createState() =>
      _CustomDismissBackgroundState();
}

class _CustomDismissBackgroundState extends State<CustomDismissBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.isSecondary!
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      padding: widget.isSecondary!
          ? EdgeInsets.only(left: 10.w)
          : EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        color: widget.isSecondary! ? Colors.green : Colors.red,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
            bottomLeft: Radius.circular(10.r),
            topLeft: Radius.circular(10.r)),
      ),
      child: widget.isSecondary!
          ? Icon(
              Icons.check,
              color: Colors.white,
              size: 40.r,
            )
          : Icon(
              Icons.delete,
              color: Colors.white,
              size: 40.r,
            ),
    );
  }
}
