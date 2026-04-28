import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';


import '../core/functions/toast/custom_toast.dart';
import '../core/utils/app_assets.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_strings.dart';
import '../core/utils/app_text_styles.dart';
import '../core/widgets/custom_buton.dart';

class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({super.key});

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  bool isLoading = false;

  Future<void> _retryConnection() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(milliseconds: 700));
    final hasConnection = await DataConnectionChecker().hasConnection;
    setState(() => isLoading = false);

    if (!hasConnection && mounted) {
      showToast(
        false,
        AppStrings.noInternetTitle,
        AppStrings.noInternetSubtitle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 37.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.imagesNoInternetConnection),
              SizedBox(height: 24.h),
              Text(
                AppStrings.noInternetWidget,
                style: AppTextStyles.dubaiRegularstyle14.copyWith(
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              CustomButton(
                textColor: AppColors.white,
                textButton: AppStrings.retry,
                buttonColor: AppColors.defaultColor,
                loading: isLoading,
                onPressed: isLoading ? (){} : _retryConnection,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
