import 'dart:developer';

import 'package:flutter/cupertino.dart';

class CustomResponsiveBuilder extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const CustomResponsiveBuilder({
    super.key,
    this.mobile,
    this.desktop,
    this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        log(' current width ${constraints.maxWidth}');
        if (constraints.maxWidth < 600) {
          return mobile ?? const SizedBox();
        } else if (constraints.maxWidth < 1100) {
          return tablet ?? const SizedBox();
        } else {
          return desktop ?? const SizedBox();
        }
      },
    );
  }
}
