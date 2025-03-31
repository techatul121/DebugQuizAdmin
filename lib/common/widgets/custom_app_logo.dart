import 'package:flutter/material.dart';

import '../constants/image_path_constants.dart';
import '../theme/app_size.dart';
import 'custom_svg.dart';

class CustomAppLogo extends StatelessWidget {
  const CustomAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSize.size20,
      children: [
        CustomSvg(assetName: SvgImages.appLogo, height: AppSize.size80),
        CustomSvg(assetName: SvgImages.appTitle, height: AppSize.size15),
      ],
    );
  }
}
