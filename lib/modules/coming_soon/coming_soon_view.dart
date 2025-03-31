import 'package:flutter/material.dart';

import '../../common/constants/app_strings_constants.dart';
import '../../common/extensions/context_extensions.dart';
import '../../common/theme/app_colors.dart';
import '../../common/widgets/custom_text_widget.dart';

class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.deviceHeight,
      alignment: Alignment.center,
      child: const Center(
        child: Text14W400(AppStrings.comingSoon, color: AppColors.black),
      ),
    );
  }
}
