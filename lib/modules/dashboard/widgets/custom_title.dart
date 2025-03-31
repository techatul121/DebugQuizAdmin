import 'package:flutter/cupertino.dart';

import '../../../common/theme/app_size.dart';
import '../../../common/widgets/custom_svg.dart';
import '../../../common/widgets/custom_text_widget.dart';

class CustomTitle extends StatelessWidget {
  final String assetName;
  final String title;

  const CustomTitle({super.key, required this.assetName, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSize.size5,
      children: [
        CustomSvg(
          height: AppSize.size24,
          width: AppSize.size24,
          assetName: assetName,
        ),
        Text24W400(title),
      ],
    );
  }
}
