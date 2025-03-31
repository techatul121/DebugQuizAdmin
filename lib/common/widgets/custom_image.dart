import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String assetName;
  final Alignment? alignment;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;

  const CustomImage({
    super.key,
    required this.assetName,
    this.height,
    this.width,
    this.alignment,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      fit: fit,
      color: color,
      alignment: alignment ?? Alignment.center,
      assetName,
      width: height,
      height: width,
    );
  }
}
