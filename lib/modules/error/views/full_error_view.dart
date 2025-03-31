import 'package:flutter/material.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/widgets/buttons/custom_filled_button.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../../../services/remote/db/db_exception.dart';

class FullErrorView extends StatelessWidget {
  const FullErrorView({super.key, required this.exception, this.onRefresh});

  final DBException exception;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: AppSize.size10,
        children: [
          Text14W700(exception.message, textAlign: TextAlign.center),
          UnconstrainedBox(
            child: CustomFilledButton(
              onTap: onRefresh,
              text: AppStrings.tryAgain,
            ),
          ),
        ],
      ),
    );
  }
}
