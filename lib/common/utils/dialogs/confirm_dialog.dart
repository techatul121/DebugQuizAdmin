import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_geometry.dart';
import '../../theme/app_size.dart';
import '../../widgets/buttons/custom_filled_button.dart';
import '../../widgets/custom_text_widget.dart';
import 'custom_dialog.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.message,
    required this.title,
    required this.onConfirm,
    required this.cancelButtonTitle,
    required this.confirmButtonTitle,
  });

  final String message;
  final String title;
  final VoidCallback onConfirm;
  final String confirmButtonTitle;
  final String cancelButtonTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.a10),
      backgroundColor: AppColors.white,
      title: Row(children: [Text24W400(title)]),
      content: Text22W400(message),
      actionsOverflowButtonSpacing: AppSize.size14,
      actions: [
        Row(
          spacing: AppSize.size5,
          children: [
            Expanded(
              child: CustomFilledButton(
                text: confirmButtonTitle,
                onTap: onConfirm,
                color: AppColors.red,
              ),
            ),
            Expanded(
              child: CustomFilledButton(
                text: cancelButtonTitle,
                onTap: CustomDialog.closeDialog,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
