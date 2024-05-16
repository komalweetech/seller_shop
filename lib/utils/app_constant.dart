import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppConstant {
  static String appName = "E Commerce";
  static const appPrimaryColor = Color(0xFFbf1b08);
  static const appSecondPrimaryColor = Color(0xFF981206);
  static const appTextColor = Color(0xFFFBF5F4);
  static const appStatusBarColor = Color(0xFFFBF5F4);

  // gradient color
  static LinearGradient primaryGradient = const LinearGradient(
    colors: [
      Color(0xffED213A),
      Color(0xff93291E),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}