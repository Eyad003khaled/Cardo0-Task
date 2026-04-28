// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import '../../utils/app_colors.dart';

// Variable to keep track of the current notification
ToastificationItem? currentNotificationId;

showToast(bool isSuccess, String title, String description) {
  if (currentNotificationId != null) {
    toastification.dismiss(currentNotificationId!);
  }

  currentNotificationId = toastification.show(
    type: isSuccess ? ToastificationType.success : ToastificationType.error,
    style: ToastificationStyle.flatColored,

    autoCloseDuration: const Duration(seconds: 5),
    title: Text(title),
    description: Text(description),
    alignment: Alignment.topCenter,
    direction:  TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    showIcon: true,
    primaryColor: isSuccess ? AppColors.validGreenColor : AppColors.errorRedColor,
    backgroundColor: isSuccess ? AppColors.validGreenColor : AppColors.errorRedColor,
    foregroundColor: isSuccess ? AppColors.validGreenColor : AppColors.errorRedColor,
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
    margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    borderRadius: BorderRadius.circular(12.r),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      ),
    ],
    showProgressBar: false,
    closeButtonShowType: CloseButtonShowType.always,
    closeOnClick: true,
    pauseOnHover: true,
    dragToClose: false,
    applyBlurEffect: true,
  );

  return Container(); // Return a placeholder widget
}
