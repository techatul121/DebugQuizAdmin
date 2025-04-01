import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/extensions/context_extensions.dart';
import '../../../common/extensions/strings_extensions.dart';
import '../../../common/extensions/validation_extensions.dart';
import '../../../common/states/page_state.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_geometry.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/utils/custom_toast.dart';
import '../../../common/utils/dialogs/custom_dialog.dart';
import '../../../common/widgets/buttons/custom_filled_button.dart';
import '../../../common/widgets/custom_drop_down_menu.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../common/widgets/custom_text_form_field.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../enums/category_type_enum.dart';
import '../models/category_request_model.dart';
import '../providers/add_category_provider.dart';
import '../providers/category_provider.dart';

class CreateCategoryView extends StatefulWidget {
  const CreateCategoryView({super.key});

  @override
  State<CreateCategoryView> createState() => _CreateCategoryViewState();
}

class _CreateCategoryViewState extends State<CreateCategoryView> {
  String name = '';
  CategoryTypeEnum? categoryTypeEnum;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.listen(addCategoryProvider, (previous, next) {
          if (next is PageLoadingState) {
            CustomDialog.loading(message: AppStrings.loading);
          } else if (next is PageErrorState) {
            CustomToast.showError(next.exception!.message);
            CustomDialog.closeDialog();
          } else if (next is PageLoadedState) {
            CustomToast.showSuccess(next.model!.message);
            ref.invalidate(categoryProvider);
            CustomDialog.closeDialog();
            CustomDialog.closeDialog();
          }
        });
        return SizedBox(
          width: context.deviceWidth * 0.3,
          child: SingleChildScrollView(
            child: Padding(
              padding: AppEdgeInsets.a20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text22W400(AppStrings.create),
                      IconButton(
                        onPressed: () {
                          CustomDialog.closeDialog();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SBH20(),
                  CustomTextFormField(
                    title: AppStrings.nameColumn,
                    borderRadius: AppBorderRadius.a15,
                    borderColor: AppColors.accentColor,
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  const SBH20(),
                  CustomDropDownMenu<CategoryTypeEnum>(
                    title: AppStrings.categoryType,
                    onSelect: (value) {
                      categoryTypeEnum = value;
                    },
                    width: context.deviceWidth,
                    initialItems:
                        CategoryTypeEnum.values
                            .map(
                              (e) => CustomDropDownMenuItem(
                                value: e,
                                label: e.name.toTitleCase(),
                              ),
                            )
                            .toList(),
                  ),
                  const SBH20(),

                  UnconstrainedBox(
                    child: CustomFilledButton(
                      text: AppStrings.create,
                      width: AppSize.size250,
                      height: AppSize.size60,
                      onTap: () {
                        if (name.isValid(AppStrings.nameColumn) &&
                            categoryTypeEnum.validateSelection(
                              AppStrings.categoryType,
                            )) {
                          ref
                              .read(addCategoryProvider.notifier)
                              .addCategory(
                                model: CategoryRequestModel(
                                  name: name,
                                  categoryType: categoryTypeEnum!.name,
                                ),
                              );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
