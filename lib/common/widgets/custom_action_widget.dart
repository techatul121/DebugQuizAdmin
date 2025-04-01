import 'package:flutter/material.dart';

import '../../../common/constants/image_path_constants.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/widgets/images/custom_tappable_svg.dart';

class CustomActionWidget extends StatelessWidget {
  const CustomActionWidget({super.key, this.onDelete, this.onEdit});

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSize.size10,
      children: [
        if (onEdit != null)
          CustomTappableSvg(
            onTap: () {
              onEdit?.call();
            },
            assetName: SvgImages.editIcon,
            height: AppSize.size24,
          ),
        if (onDelete != null)
          CustomTappableSvg(
            onTap: () {
              onDelete?.call();
            },
            assetName: SvgImages.deleteIcon,
            height: AppSize.size24,
          ),
      ],
    );
  }
}
