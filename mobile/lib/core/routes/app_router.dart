import 'package:flutter/material.dart';
import 'package:mobile/features/readings/presentation/screens/reading_screen.dart';

import '../functions/animation/animation.dart';

class AppRouter {
  static const String readingScreen = '/reading_screen';

// Generate routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case readingScreen:
         return fadeRoute(const ReadingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
  
}
