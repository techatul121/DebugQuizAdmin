import 'package:flutter/material.dart';

import '../../../../common/theme/app_colors.dart';
import '../../../../common/theme/app_geometry.dart';
import '../../../../common/theme/app_size.dart';
import '../../../../common/widgets/custom_svg.dart';
import '../../../../common/widgets/custom_text_widget.dart';

class CustomMenuTile extends StatelessWidget {
  const CustomMenuTile({
    super.key,
    required this.title,
    required this.iconPath,
    this.isSelected = false,
    this.hover = true,
    this.onTap,
  });

  final String title;
  final String iconPath;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool hover;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap?.call,
      child: Container(
        padding: EdgeInsets.only(left: AppSize.size10),
        height: AppSize.size50,
        decoration:
            isSelected
                ? BoxDecoration(
                  gradient: AppColors.whiteToBlueGradient,
                  borderRadius: AppBorderRadius.tl10bl10,
                )
                : null,
        child: Row(
          spacing: AppSize.size10,
          children: [
            CustomSvg(
              height: AppSize.size24,
              width: AppSize.size24,
              assetName: iconPath,
              color: isSelected ? AppColors.blue : AppColors.white,
            ),
            Text16W500(
              title,
              color: isSelected ? AppColors.blue : AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
