import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  final String assetName;
  final Alignment? alignment;
  final double? height;
  final double? width;
  final Color? color;

  const CustomSvg({
    super.key,
    required this.assetName,
    this.height,
    this.width,
    this.alignment,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      alignment: alignment ?? Alignment.center,
      assetName,
      width: width,
      height: height,
    );
  }
}
