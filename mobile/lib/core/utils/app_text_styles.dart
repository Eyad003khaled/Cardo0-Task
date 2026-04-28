import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';


abstract class AppTextStyles {
  static final dubaiRegularstyle14 = TextStyle(
    fontFamily: "Dubai",
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: AppColors.defaultColor,
  );
  static final dubaiMediumstyle14 = TextStyle(
    fontFamily: "Dubai",
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    color: AppColors.defaultColor,
  );
  static final dubaiSemiBoldstyle14 = TextStyle(
    fontFamily: "Dubai",
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.defaultColor,
  );
  static final dubaiBoldstyle14 = TextStyle(
    fontFamily: "Dubai",
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.defaultColor,
  );

  static final tajawalMediumstyle14 = TextStyle(
    fontFamily: "Tajawal",
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    color: AppColors.defaultColor,
  );
  static final interRegularstyle14 = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: AppColors.defaultColor,
  );
  static final poppinsRegularstyle12 = TextStyle(
    fontFamily: "Poppins",
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: AppColors.defaultColor,
  );
  static final plusJakartaSansRegularstyle12 = TextStyle(
    fontFamily: "PlusJakartaSans",
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: AppColors.white,
  );
  static final plusJakartaSansBoldstyle14 = TextStyle(
    fontFamily: "PlusJakartaSans",
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
}