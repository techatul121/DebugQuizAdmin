import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// if width is less than 600 then it is mobile
  bool get isMobile => MediaQuery.sizeOf(this).width < 600;

  /// if width is greater than 600 and less than 1024 then it is tablet
  bool get isTablet =>
      MediaQuery.sizeOf(this).width >= 600 &&
      MediaQuery.sizeOf(this).width <= 1100;

  /// if width is greater than 1024 then it is desktop
  bool get isDesktop => MediaQuery.of(this).size.width > 1100;

  double get deviceWidth => MediaQuery.sizeOf(this).width;

  double get deviceHeight => MediaQuery.sizeOf(this).height;
}
