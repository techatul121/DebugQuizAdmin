import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_geometry.dart';
import '../../theme/app_size.dart';
import '../../widgets/custom_text_widget.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Center(
        child: Container(
          // height: context.isDesktop ? AppSize.size200 : AppSize.size150,
          width: AppSize.size190,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: AppBorderRadius.a10,
          ),
          child: Padding(
            padding: AppEdgeInsets.a20,
            child: Column(
              spacing: AppSize.size50,
              children: [
                const CircularProgressIndicator(),
                Text14W700(message, color: AppColors.blue),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
