import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/device_type_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.textColor,
    this.buttonColor,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonTextStyle,
    this.borderColor,
    this.borderRadius,
    this.buttonFontSize,
    required this.textButton,
    required this.onPressed,
    this.child,
    this.loading = false, // ✅ New parameter
  });

  final Color textColor;
  final Color? buttonColor;
  final Color? borderColor;
  final String textButton;
  final double? buttonWidth;
  final double? buttonFontSize;
  final double? buttonHeight;
  final double? borderRadius;
  final TextStyle? buttonTextStyle;
  final VoidCallback onPressed;
  final Widget? child;
  final bool loading; // ✅ New

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPressed, // ✅ Disable tap when loading
      child: Container(
        width: buttonWidth ?? double.infinity,
        height:
            buttonHeight ??
            (DeviceTypeService.isLandscape(context) ? 64 : 43.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ??12.r),
          border: Border.all(color: borderColor ?? AppColors.defaultColor),
          color: buttonColor ?? Colors.transparent,
        ),
        child: Center(
          child:
              loading
                  ? SizedBox(
                    height: 30.h,
                    width: 30.w,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    ),
                  )
                  : (child ??
                      Text(
                        textButton,
                        style:
                            buttonTextStyle ??
                            AppTextStyles.dubaiMediumstyle14.copyWith(
                              fontSize:buttonFontSize?? 18.sp,
                              color: textColor,
                            ),
                        textAlign: TextAlign.center,
                      )),
        ),
      ),
    );
  }
}
