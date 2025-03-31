import 'package:flutter/material.dart';

import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_geometry.dart';

class CustomAddFloatingButton extends StatelessWidget {
  const CustomAddFloatingButton({
    super.key,
    required this.onTap,
    this.icons = const Icon(Icons.add_box),
    this.enabled = true,
  });

  final VoidCallback onTap;
  final Widget icons;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: enabled ? onTap : null,
      backgroundColor: enabled ? AppColors.blue : AppColors.grey,
      shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.a15),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: AppBorderRadius.a15,
          boxShadow: [
            BoxShadow(
              color:
                  enabled
                      ? AppColors.blue.withValues(alpha: 0.2)
                      : Colors.transparent,
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Opacity(opacity: enabled ? 1.0 : 0.5, child: icons),
      ),
    );
  }
}
