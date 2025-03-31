import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.iconData,
    this.size,
    this.color,
    this.onTap,
  });

  final IconData iconData;
  final double? size;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData, color: color, size: size),
      onPressed: onTap,
    );
  }
}
