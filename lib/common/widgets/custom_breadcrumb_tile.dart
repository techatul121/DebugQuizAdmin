import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_size.dart';
import 'custom_sized_box.dart';
import 'custom_text_widget.dart';

class CustomBreadcrumbTile extends StatelessWidget {
  final String mainText;
  final String text;

  const CustomBreadcrumbTile({
    super.key,
    required this.mainText,
    required this.text,
    this.onMainTextTap,
  });

  final VoidCallback? onMainTextTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            onMainTextTap?.call();
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text14W700(mainText, color: AppColors.grey),
          ),
        ),
        const SBW5(),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: AppSize.size20,
        ),
        const SBW5(),
        Text14W700(text),
      ],
    );
  }
}
