import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_size.dart';
import '../custom_shimmer_widget.dart';
import '../custom_svg.dart';

class CustomNetworkImagePlaceholder extends StatelessWidget {
  const CustomNetworkImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightGrey,
      height: AppSize.size100,
      child: CustomShimmerWidget(
        baseColor: Colors.grey.shade400,
        child: UnconstrainedBox(
          child: CustomSvg(assetName: '', height: AppSize.size40),
        ),
      ),
    );
  }
}
