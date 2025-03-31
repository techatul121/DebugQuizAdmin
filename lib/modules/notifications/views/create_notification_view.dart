import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/enums/notification_type_enums.dart';
import '../../../common/extensions/context_extensions.dart';
import '../../../common/extensions/validation_extensions.dart';

import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_geometry.dart';
import '../../../common/theme/app_size.dart';

import '../../../common/utils/dialogs/custom_dialog.dart';
import '../../../common/widgets/buttons/custom_filled_button.dart';
import '../../../common/widgets/custom_drop_down_menu_with_pagination.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../common/widgets/custom_text_form_field.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../models/city_list_request_model.dart';
import '../models/city_list_response_model.dart';
import '../models/project_list_request_model.dart';
import '../models/project_list_response_model.dart';
import '../models/send_notification_request_model.dart';

import '../providers/send_notification_provider.dart';

import '../widgets/custom_notification_type_selector.dart';

class CreateNotificationView extends ConsumerStatefulWidget {
  const CreateNotificationView({super.key});

  @override
  ConsumerState<CreateNotificationView> createState() =>
      _CreateNotificationViewState();
}

class _CreateNotificationViewState
    extends ConsumerState<CreateNotificationView> {
  final dropdownControllerForCity =
      CustomDropDownMenuPaginationController<CityModel>();
  final dropdownControllerForProject =
      CustomDropDownMenuPaginationController<ProjectModel>();
  late final CityListRequestModel cityListRequestModel;
  late final ProjectListRequestModel projectListRequestModel;

  CityModel? selectedCity;

  final ValueNotifier<ProjectModel?> selectedProject =
      ValueNotifier<ProjectModel?>(null);
  String content = '';
  String selectedImageUrl = '';
  NotificationTypeEnums selectedNotificationTypeEnum =
      NotificationTypeEnums.cityWise;
  final ScrollController cityScrollController = ScrollController();
  final ScrollController projectScrollController = ScrollController();
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    cityListRequestModel = CityListRequestModel();
    projectListRequestModel = ProjectListRequestModel();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    cityScrollController.dispose();
    projectScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.deviceWidth * 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SBH10(),
          Column(
            children: [
              Padding(
                padding: AppEdgeInsets.h10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text22W400(AppStrings.sendNotification),
                    IconButton(
                      onPressed: () {
                        CustomDialog.closeDialog();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),

          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppEdgeInsets.a20,
                child: Column(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        title: AppStrings.title,
                        maxLength: 60,
                        controller: _titleController,
                        borderColor: AppColors.accentColor,
                      ),
                    ),
                    const SBH20(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppSize.size10,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            title: AppStrings.body,
                            heightTextFormField: AppSize.size220,
                            maxLength: 120,
                            maxLines: 10,
                            borderColor: AppColors.accentColor,
                            onChanged: (value) {
                              content = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SBH20(),
                    CustomNotificationTypeSelector(
                      onSelected: (value) {
                        log('selected $value');
                        selectedNotificationTypeEnum = value;
                      },
                    ),
                    const SBH20(),
                    UnconstrainedBox(
                      child: CustomFilledButton(
                        text: AppStrings.send,
                        width: AppSize.size250,
                        onTap: () {
                          log(
                            'Selected city $selectedImageUrl ${selectedNotificationTypeEnum.name}',
                          );

                          if (selectedCity.validateSelection(AppStrings.city) &&
                              selectedProject.value.validateSelection(
                                AppStrings.project,
                              ) &&
                              _titleController.text.isValid(AppStrings.title) &&
                              content.isValid(AppStrings.content)) {
                            ref
                                .read(sendNotificationProvider.notifier)
                                .sendNotification(
                                  SendNotificationRequestModel(
                                    imageUrl: selectedImageUrl,
                                    title: _titleController.text,
                                    body: content,
                                    notificationType:
                                        selectedNotificationTypeEnum,
                                  ),
                                  selectedProject.value!.id,
                                );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
