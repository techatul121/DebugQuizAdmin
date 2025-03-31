import 'package:flutter/material.dart';

import '../theme/app_geometry.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = AppEdgeInsets.a10,
    this.margin,
    this.borderColor,
    this.borderRadius = AppBorderRadius.a10,
    this.height,
    this.width,
  });

  final Widget child;
  final GestureTapCallback? onTap;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? AppBorderRadius.a20;
    return Card(
      elevation: 8,
      margin: margin,
      // shadowColor: AppColors.black.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side:
            borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
