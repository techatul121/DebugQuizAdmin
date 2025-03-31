import 'package:flutter/material.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/theme/app_geometry.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/widgets/buttons/custom_filled_button.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../../../services/remote/db/db_exception.dart';

class BottomErrorView extends StatelessWidget {
  const BottomErrorView({super.key, required this.exception, this.onRefresh});

  final DBException exception;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppEdgeInsets.a10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSize.size10,
        children: [
          Text14W700(exception.message),
          UnconstrainedBox(
            child: CustomFilledButton(
              height: AppSize.size60,
              width: AppSize.size250,
              onTap: onRefresh,
              text: AppStrings.tryAgain,
            ),
          ),
        ],
      ),
    );
  }
}
