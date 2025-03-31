import 'package:flutter/material.dart';

class CustomResponsiveCenterWidget extends StatelessWidget {
  const CustomResponsiveCenterWidget({
    super.key,
    // this.maxWidth = 600,
    this.maxWidth = 600,
    required this.child,
  });

  final double maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Center(child: SizedBox(width: maxWidth, child: child));
}
