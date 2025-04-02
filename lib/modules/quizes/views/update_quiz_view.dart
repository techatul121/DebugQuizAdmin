import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../common/views/auto_dispose_page_view.dart';
import '../../../common/widgets/buttons/custom_filled_button.dart';
import '../../../common/widgets/custom_drop_down_menu.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../common/widgets/custom_text_form_field.dart';
import '../../../common/widgets/custom_text_widget.dart';

import '../../category/models/category_model.dart';
import '../../category/providers/category_provider.dart';

import '../enums/quiz_type_enum.dart';
import '../models/quiz_model.dart';
import '../models/update_quiz_request_model.dart';
import '../providers/add_quiz_provider.dart';

import '../providers/edit_quiz_provider.dart';
import '../providers/quiz_provider.dart';

class UpdateQuizView extends StatefulWidget {
  const UpdateQuizView({super.key, required this.quizModel});
  final QuizModel quizModel;
  @override
  State<UpdateQuizView> createState() => _UpdateQuizViewState();
}

class _UpdateQuizViewState extends State<UpdateQuizView> {
  String title = '';
  String shortDescription = '';
  int totalTime = 0;
  CategoryModel? categoryModel;
  QuizTypeEnum quizTypeEnum = QuizTypeEnum.free;
  @override
  void initState() {
    super.initState();
    title = widget.quizModel.title;
    shortDescription = widget.quizModel.shortDescription;
    totalTime = widget.quizModel.timeLimit;
    quizTypeEnum = widget.quizModel.quizType;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.listen(addQuizProvider, (previous, next) {
          if (next is PageLoadingState) {
            CustomDialog.loading(message: AppStrings.loading);
          } else if (next is PageErrorState) {
            CustomToast.showError(next.exception!.message);
            CustomDialog.closeDialog();
          } else if (next is PageLoadedState) {
            CustomToast.showSuccess(next.model!.message);
            ref.invalidate(quizProvider);
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
                  AutoDisposePageView<List<CategoryModel>>(
                    provider: categoryProvider,
                    success: (data) {
                      final initialValue = data.firstWhere(
                        (e) => e.id == widget.quizModel.categoryId,
                      );
                      categoryModel = initialValue;
                      return CustomDropDownMenu<CategoryModel>(
                        title: AppStrings.selectCategory,
                        initialValue: initialValue,
                        onSelect: (value) {
                          categoryModel = value;
                        },
                        width: context.deviceWidth,
                        initialItems:
                            data
                                .map(
                                  (e) => CustomDropDownMenuItem(
                                    value: e,
                                    label: e.name.toTitleCase(),
                                  ),
                                )
                                .toList(),
                      );
                    },
                  ),

                  const SBH20(),
                  CustomTextFormField(
                    title: AppStrings.title,
                    initialValue: title,
                    borderRadius: AppBorderRadius.a15,
                    borderColor: AppColors.accentColor,
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  const SBH20(),
                  CustomTextFormField(
                    title: AppStrings.shortDescription,
                    initialValue: shortDescription,
                    heightTextFormField: AppSize.size100,
                    borderRadius: AppBorderRadius.a15,
                    borderColor: AppColors.accentColor,
                    maxLines: 4,
                    onChanged: (value) {
                      shortDescription = value;
                    },
                  ),
                  const SBH20(),
                  CustomTextFormField(
                    title: AppStrings.totalTime,
                    initialValue: totalTime.toString(),
                    borderRadius: AppBorderRadius.a15,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    inputType: TextInputType.number,
                    borderColor: AppColors.accentColor,
                    onChanged: (value) {
                      totalTime = int.parse(value);
                    },
                  ),
                  const SBH20(),
                  CustomDropDownMenu<QuizTypeEnum>(
                    title: AppStrings.quizTypeColumn,

                    initialValue: quizTypeEnum,
                    autoFocus: false,
                    onSelect: (value) {
                      quizTypeEnum = value;
                    },
                    width: context.deviceWidth,
                    initialItems:
                        QuizTypeEnum.values
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
                      text: AppStrings.update,
                      width: AppSize.size250,
                      height: AppSize.size60,
                      onTap: () {
                        if (categoryModel.validateSelection(
                              AppStrings.selectCategory,
                            ) &&
                            title.isValid(AppStrings.title) &&
                            shortDescription.isValid(
                              AppStrings.shortDescription,
                            ) &&
                            totalTime.validTime(AppStrings.totalTime)) {
                          log('Edit quiz');
                          ref
                              .read(editQuizProvider.notifier)
                              .editQuiz(
                                model: UpdateQuizRequestModel(
                                  id: widget.quizModel.id,
                                  title: title,
                                  shortDescription: shortDescription,
                                  timeLimit: totalTime,
                                  categoryId: categoryModel!.id,
                                  quizTypeEnum: quizTypeEnum,
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
