import 'package:flutter/material.dart';

class DeviceTypeService {
  static const double tabletBreakpoint = 600.0;

  static bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide >= tabletBreakpoint;
  }

  static bool isMobile(BuildContext context) {
    return !isTablet(context);
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }
}
