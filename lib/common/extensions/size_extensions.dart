import 'dart:math';

class Sizes {
  static const double _defaultWidth = 1920;
  static const double _defaultHeight = 1080;

  /// For mobile devices
  // static const double _defaultWidthForMobile = 360;
  // static const double _defaultHeightForMobile = 690;

  static double get defaultWidth => _defaultWidth;

  static double get defaultHeight => _defaultHeight;

  static double width = defaultWidth;
  static double height = defaultHeight;
}

extension SizeExtension on num {
  /// Calculates the scalable pixel (sp) depending on the device's screen size.

  double get sp {
    double originalDiagonal = sqrt(
      pow(Sizes.defaultWidth, 2) + pow(Sizes.defaultHeight, 2),
    );
    double newDiagonal = sqrt(pow(Sizes.width, 2) + pow(Sizes.height, 2));

    return this * (newDiagonal / originalDiagonal);
  }
}
