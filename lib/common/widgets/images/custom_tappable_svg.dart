import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTappableSvg extends StatelessWidget {
  final String assetName;
  final Alignment? alignment;
  final double? height;
  final double? width;
  final Color? color;
  final VoidCallback? onTap;

  const CustomTappableSvg({
    super.key,
    required this.assetName,
    this.height,
    this.width,
    this.alignment,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SvgPicture.asset(
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          alignment: alignment ?? Alignment.center,
          assetName,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
