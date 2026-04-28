import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/app/cardoo.dart';

import 'core/services/injection.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
      // 🔹 Dependency Injection
  initGetIt();

    // 🔹 Device setup
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await ScreenUtil.ensureScreenSize();

  runApp(const Cardoo());
}

