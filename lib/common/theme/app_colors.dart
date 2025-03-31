import 'package:flutter/material.dart';

class AppColors {
  static const Color transparent = Color(0x00000000);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFF23535);
  static const Color green = Color(0xFF4CAF50);
  static const Color blue = Color(0xFF4c662b);
  static const Color lightBlue = Color(0xFF2EB3B8);
  static const Color grey = Color(0xFFB3B3B3);
  static const Color lightGrey = Color(0xFFB3B3B3);
  static const Color orange = Color(0xffFB8D48);
  static const Color borderColor = Color(0xffE8E8E8);
  static const Color darkColor = Color(0xff1f1f1f);
  static const Color highlightColor = Color(0xffBDEAF2);
  static const Color darkGrayColor = Color(0xff3C3939);
  static const Color accentColor = Color(0xff2C3131);
  static LinearGradient whiteToBlueGradient = LinearGradient(
    colors: [AppColors.white, AppColors.white.withValues(alpha: 0)],
    stops: [0.4, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
