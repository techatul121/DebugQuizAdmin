import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/constants/image_path_constants.dart';
import '../../../common/models/base_response_model.dart';
import '../../../common/states/page_state.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/utils/custom_toast.dart';
import '../../../common/utils/dialogs/custom_dialog.dart';
import '../../../common/widgets/buttons/custom_filled_button.dart';
import '../../../common/widgets/custom_card.dart';
import '../../../common/widgets/custom_svg.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../provider/clear_cache_provider.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  static const String path = '/settings';
  static const String name = 'settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<PageState<BaseResponseModel>>(clearCacheProvider, (_, next) {
      if (next is PageLoadingState) {
        CustomDialog.loading(message: AppStrings.loading);
      } else if (next is PageErrorState) {
        CustomToast.showError(next.exception!.message);
        CustomDialog.closeDialog();
      } else if (next is PageLoadedState) {
        CustomToast.showSuccess(next.model!.message);
        CustomDialog.closeDialog();
        CustomDialog.closeDialog();
      }
    });
    return Column(
      spacing: AppSize.size20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text36W400(AppStrings.settings),
        CustomCard(
          child: Column(
            spacing: AppSize.size10,
            children: [
              Column(
                spacing: AppSize.size10,
                children: [
                  Row(
                    spacing: AppSize.size10,
                    children: [
                      CustomSvg(
                        assetName: SvgImages.documentIcon,
                        height: AppSize.size24,
                        width: AppSize.size24,
                      ),
                      const Text22W400(AppStrings.clearCache),
                    ],
                  ),

                  const Divider(color: AppColors.borderColor),
                ],
              ),

              Row(
                children: [
                  const Expanded(child: Text16W500(AppStrings.clearInfo)),
                  CustomFilledButton(
                    text: AppStrings.clear,
                    onTap: () {
                      CustomDialog.confirmDialog(
                        message: AppStrings.clearCacheConfirmation,
                        onConfirm: () {
                          ref.read(clearCacheProvider.notifier).clearCache();
                        },
                      );
                    },
                    height: AppSize.size50,
                    width: AppSize.size160,
                    color: AppColors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
