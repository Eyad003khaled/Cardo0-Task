import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/injection.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../cubit/reading_cubit.dart';
import '../widgets/Reading_widget.dart';

class ReadingScreen extends StatelessWidget {
  const ReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Cardo0 Real Time Readings",
            style: AppTextStyles.dubaiMediumstyle14.copyWith(fontSize: 22.sp, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt<ReadingCubit>()..fetchReading()..startAutoRefresh(),
          child: const ReadingWidget(),
        ),
      ),
    );
  }
}
