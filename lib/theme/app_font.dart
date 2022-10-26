import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTypography {
  static TextStyle superHeadline = GoogleFonts.roboto(
    fontSize: 30.r,
    color: AppColor.textPrimary,
  );
  static TextStyle headline = GoogleFonts.roboto(
    fontSize: 26.r,
    color: AppColor.textPrimary,
  );
  static TextStyle subHeadline = GoogleFonts.roboto(
    fontSize: 24.r,
    color: AppColor.textPrimary,
  );
  static TextStyle title = GoogleFonts.roboto(
    fontSize: 18.r,
    color: AppColor.textPrimary,
  );
  static TextStyle body = GoogleFonts.roboto(
    fontSize: 16.r,
    color: AppColor.textPrimary,
  );
  static TextStyle bodySmall = GoogleFonts.roboto(
    fontSize: 14.r,
    color: AppColor.textPrimary,
  );
}
