import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_geometry.dart';
import 'app_size.dart';

class AppTheme {
  static AppBarTheme _appBarTheme() => AppBarTheme(
    centerTitle: true,
    iconTheme: IconThemeData(size: AppSize.size24, color: AppColors.black),
    titleTextStyle: _w700(fontSize: AppSize.size24, color: AppColors.black),
  );

  static BadgeThemeData _badgeThemeData({required Color backgroundColor}) =>
      BadgeThemeData(
        textStyle: _w500(fontSize: AppSize.size10),
        backgroundColor: backgroundColor,
      );

  static DrawerThemeData _drawerTheme() =>
      const DrawerThemeData(backgroundColor: AppColors.black, elevation: 2);

  static ElevatedButtonThemeData _elevatedButtonThemeData() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: AppColors.blue,
          foregroundColor: AppColors.white,
          textStyle: _w500(fontSize: AppSize.size16),
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorderRadius.a10,
          ),
        ),
      );

  static OutlinedButtonThemeData _outlineButtonThemeData() =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 2,
          textStyle: _w500(fontSize: AppSize.size16),
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorderRadius.a10,
            side: BorderSide(color: AppColors.blue),
          ),
        ),
      );

  static ExpansionTileThemeData _expansionTileThemeData() =>
      ExpansionTileThemeData(
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: AppBorderRadius.a20,
        ),
        shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.a20),
        iconColor: AppColors.white,
        collapsedIconColor: AppColors.white,
        backgroundColor: AppColors.transparent,
        collapsedBackgroundColor: AppColors.transparent,
        expansionAnimationStyle: AnimationStyle(duration: Durations.medium4),
      );

  static FloatingActionButtonThemeData _floatingActionButtonThemeData() =>
      const FloatingActionButtonThemeData(
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        elevation: 2,
      );

  static IconThemeData _iconThemeData({required Color color}) =>
      IconThemeData(size: AppSize.size30, color: color);

  static InputDecorationTheme _inputDecorationTheme({
    required Color fillColor,
    required Color borderColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      labelStyle: _w400(fontSize: AppSize.size16, color: borderColor),
      hintStyle: _w500(fontSize: AppSize.size18, color: AppColors.grey),
      border: _outlineInputBorder(borderColor: AppColors.accentColor),
      contentPadding: AppEdgeInsets.a10,
      focusedBorder: _outlineInputBorder(borderColor: AppColors.accentColor),
      disabledBorder: _outlineInputBorder(borderColor: AppColors.lightGrey),
      enabledBorder: _outlineInputBorder(borderColor: AppColors.lightGrey),
      errorBorder: _outlineInputBorder(borderColor: AppColors.red),
      focusedErrorBorder: _outlineInputBorder(borderColor: AppColors.red),
    );
  }

  static ListTileThemeData _listTileTheme() => ListTileThemeData(
    dense: true,
    contentPadding: EdgeInsets.zero,
    horizontalTitleGap: AppSize.size10,
    selectedColor: AppColors.white,
    selectedTileColor: AppColors.blue,
    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
  );

  static InputBorder _outlineInputBorder({required Color borderColor}) =>
      OutlineInputBorder(
        borderRadius: AppBorderRadius.a10,
        borderSide: BorderSide(color: borderColor),
      );

  static SliderThemeData _sliderThemeData() => SliderThemeData(
    activeTrackColor: AppColors.blue,
    inactiveTrackColor: AppColors.lightGrey,
    thumbColor: AppColors.blue,
    overlayColor: AppColors.blue,
    overlayShape: SliderComponentShape.noThumb,
  );

  static TextSelectionThemeData _textSelectionThemeData() =>
      const TextSelectionThemeData(cursorColor: AppColors.black);

  static TextButtonThemeData _textButtonThemeData() => TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: AppColors.black,
      textStyle: _w500(fontSize: AppSize.size20),
    ),
  );

  static TabBarThemeData _tabBarTheme({required Color color}) =>
      TabBarThemeData(
        labelPadding: AppEdgeInsets.h100,
        labelColor: AppColors.white,
        labelStyle: _w500(fontSize: AppSize.size16, color: color),
        unselectedLabelStyle: _w500(fontSize: AppSize.size16),
        unselectedLabelColor: AppColors.grey,
        indicator: BoxDecoration(
          color: color,
          borderRadius: AppBorderRadius.a10,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabAlignment: TabAlignment.start,
        dividerHeight: 0,
      );

  static TextTheme _textTheme({required Color color}) => TextTheme(
    displayLarge: _w400(fontSize: AppSize.size57, color: color),
    displayMedium: _w400(fontSize: AppSize.size45, color: color),
    displaySmall: _w400(fontSize: AppSize.size36, color: color),
    headlineLarge: _w400(fontSize: AppSize.size32, color: color),
    headlineMedium: _w400(fontSize: AppSize.size28, color: color),
    headlineSmall: _w400(fontSize: AppSize.size24, color: color),
    titleLarge: _w400(fontSize: AppSize.size22, color: color),
    titleMedium: _w500(fontSize: AppSize.size16, color: color),
    titleSmall: _w500(fontSize: AppSize.size14, color: color),
    bodyLarge: _w400(fontSize: AppSize.size16, color: color),
    bodyMedium: _w400(fontSize: AppSize.size14, color: color),
    bodySmall: _w400(fontSize: AppSize.size12, color: color),
    labelLarge: _w700(fontSize: AppSize.size14, color: color),
    labelMedium: _w500(fontSize: AppSize.size12, color: color),
    labelSmall: _w500(fontSize: AppSize.size11, color: color),
  );

  static TextStyle _w700({required double fontSize, Color? color}) =>
      GoogleFonts.urbanist(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle _w500({required double fontSize, Color? color}) =>
      GoogleFonts.urbanist(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle _w400({required double fontSize, Color? color}) =>
      GoogleFonts.urbanist(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static ThemeData get lightTheme => ThemeData(
    appBarTheme: _appBarTheme(),
    tabBarTheme: _tabBarTheme(color: AppColors.blue),
    badgeTheme: _badgeThemeData(backgroundColor: AppColors.blue),
    colorScheme: const ColorScheme.light(
      primary: AppColors.blue,
      surfaceTint: AppColors.white,

      surface: Colors.white,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.a10),
      color: Colors.white, // Explicitly set popup background color
      surfaceTintColor: Colors.transparent, // Prevents Material 3 tint effect
    ),
    useMaterial3: true,
    outlinedButtonTheme: _outlineButtonThemeData(),
    dividerTheme: const DividerThemeData(
      space: 0,
      thickness: 1,
      color: AppColors.grey,
    ),
    dividerColor: AppColors.accentColor,
    elevatedButtonTheme: _elevatedButtonThemeData(),
    floatingActionButtonTheme: _floatingActionButtonThemeData(),
    iconTheme: _iconThemeData(color: AppColors.black),
    expansionTileTheme: _expansionTileThemeData(),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        iconSize: AppSize.size24,
        tapTargetSize: MaterialTapTargetSize.padded,
      ),
    ),
    inputDecorationTheme: _inputDecorationTheme(
      fillColor: AppColors.white,
      borderColor: AppColors.lightGrey,
    ),
    listTileTheme: _listTileTheme(),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.blue,
    ),
    scaffoldBackgroundColor: AppColors.highlightColor.withValues(alpha: 0.1),
    sliderTheme: _sliderThemeData(),
    drawerTheme: _drawerTheme(),
    textButtonTheme: _textButtonThemeData(),
    textSelectionTheme: _textSelectionThemeData(),
    textTheme: _textTheme(color: AppColors.accentColor),
    dialogTheme: const DialogThemeData(backgroundColor: AppColors.white),
  );

  /// Define dark theme
  // static ThemeData darkTheme = ThemeData(
  //   brightness: Brightness.dark,
  //   primaryColor: Colors.tealAccent,
  //   scaffoldBackgroundColor: Colors.black,
  //   textTheme: const TextTheme(
  //     displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
  //     bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
  //   ),
  //   appBarTheme: const AppBarTheme(
  //     backgroundColor: Colors.tealAccent,
  //     elevation: 0,
  //   ),
  //   buttonTheme: const ButtonThemeData(
  //     buttonColor: Colors.tealAccent,
  //     textTheme: ButtonTextTheme.primary,
  //   ),
  // );
}
