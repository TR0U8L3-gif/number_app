import 'dart:ffi';

import 'package:flutter/material.dart';

const String fontFamily = "";

const double paddingSmall = 8.0;
const double paddingMedium = 16.0;
const double paddingLarge = 24.0;

const double fontSmall = 18.0;
const double fontMedium = 24.0;
const double fontLarge = 42.0;
class AppColors {
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color darkBackground = Color(0xFF2A333C);

  static const Color lightBlue = Color(0xFF586ba4);
  static const Color darkBlue = Color(0xFF324376);

  static const Color lightYellow = Color(0xFFffc765);
  static const Color darkYellow = Color(0xFF99773c);

  static const Color lightOrange = Color(0xFFf68e5f);
  static const Color darkOrange = Color(0xFF905237);

  static const Color lightText = Color(0xFFF5F5F5);
  static const Color grayText = Color(0xFF6D7694);
  static const Color darkText = Color(0xFF1D2E49);

  static const Color transparent = Colors.transparent;
}

ThemeData theme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.darkBlue,
    brightness: Brightness.light,
  ),
);

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}