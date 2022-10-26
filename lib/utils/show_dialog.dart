import 'package:ecom/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showDialogAlert(
    {required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required void Function()? onPressed}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      alignment: Alignment.center,
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline3!.copyWith(
              fontWeight: FontWeight.normal,
            ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            buildThemeButton(
              context,
              widget: Text(
                buttonText,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: AppColor.buttonColor,
                    ),
              ),
              color: Theme.of(context).primaryColor,
              function: onPressed,
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildThemeButton(BuildContext context,
    {required Widget widget,
    required Color color,
    double? elevation,
    double? width,
    double? height,
    double? borderRadius,
    required void Function()? function}) {
  return SizedBox(
    height: height,
    width: width ?? MediaQuery.of(context).size.width,
    child: ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double?>(elevation),
        backgroundColor: MaterialStateProperty.all<Color>(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 18.0),
            side: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
      onPressed: function,
      child: widget,
    ),
  );
}
