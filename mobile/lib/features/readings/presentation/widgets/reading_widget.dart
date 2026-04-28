import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_buton.dart';
import '../cubit/reading_cubit.dart';
import 'reading_chart.dart';
import 'sensor_card.dart';

class ReadingWidget extends StatelessWidget {
  const ReadingWidget({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ReadingCubit>().fetchReading();
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      color: AppColors.defaultColor,
      backgroundColor: AppColors.backgroundColor,

      /// 🔥 FIX: Scrollable wrapper
      child: BlocBuilder<ReadingCubit, ReadingState>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(), // ✅ KEY
            child: SizedBox(
              height: MediaQuery.of(context).size.height, // ✅ KEY
              child: _buildContent(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, ReadingState state) {
    if (state is ReadingLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.defaultColor,
        ),
      );
    }

    if (state is ReadingSuccess) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Dashboard",
                style: AppTextStyles.dubaiBoldstyle14.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 🥧 Pie Chart
            ReadingPieChart(reading: state.reading),

            const SizedBox(height: 20),

            /// 🌡 Temperature
            SensorCard(
              title: "Temperature",
              value:
                  "${state.reading.temperature.toStringAsFixed(1)} °C",
              icon: Icons.thermostat,
              color: Colors.redAccent,
            ),

            /// 💧 Humidity
            SensorCard(
              title: "Humidity",
              value:
                  "${state.reading.humidity.toStringAsFixed(1)} %",
              icon: Icons.water_drop,
              color: Colors.blueAccent,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () =>
                    context.read<ReadingCubit>().fetchReading(),
                textColor: Colors.white,
                buttonColor: AppColors.defaultColor,
                textButton: "Refresh Data",
              ),
            ),
          ],
        ),
      );
    }

    if (state is ReadingError) {
      return Center(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 60),
              SizedBox(height: 10.sp),
              Text(
                "No Readings Yet",
                style: AppTextStyles.dubaiMediumstyle14.copyWith(
                  color: AppColors.defaultColor,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 60.sp),
              CustomButton(
                onPressed: () =>
                    context.read<ReadingCubit>().fetchReading(),
                textColor: AppColors.white,
                buttonColor: AppColors.defaultColor,
                textButton: "Try Again",
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: CustomButton(
        onPressed: () =>
            context.read<ReadingCubit>().fetchReading(),
        textColor: AppColors.white,
        buttonColor: AppColors.defaultColor,
        textButton: "Load Data",
      ),
    );
  }
}