import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../custom_text_widget.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, this.onTap, this.title = '', this.child});

  final VoidCallback? onTap;
  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        overlayColor: WidgetStatePropertyAll(AppColors.transparent),
      ),
      onPressed: onTap,
      child: child ?? Text14W400(title),
    );
  }
}
