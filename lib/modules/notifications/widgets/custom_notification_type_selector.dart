import 'package:flutter/material.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/enums/notification_type_enums.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../common/widgets/custom_text_widget.dart';

class CustomNotificationTypeSelector extends StatefulWidget {
  const CustomNotificationTypeSelector({super.key, required this.onSelected});

  final Function(NotificationTypeEnums typeEnum) onSelected;

  @override
  State<CustomNotificationTypeSelector> createState() =>
      _CustomNotificationTypeSelectorState();
}

class _CustomNotificationTypeSelectorState
    extends State<CustomNotificationTypeSelector> {
  final ValueNotifier<NotificationTypeEnums> selectedNotificationType =
      ValueNotifier<NotificationTypeEnums>(NotificationTypeEnums.cityWise);

  @override
  void initState() {
    super.initState();
    widget.onSelected(selectedNotificationType.value);
  }

  @override
  void dispose() {
    selectedNotificationType.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text16W500(AppStrings.sendNotificationType),
        const SBH5(),
        ValueListenableBuilder<NotificationTypeEnums>(
          valueListenable: selectedNotificationType,
          builder: (context, value, child) {
            return Row(
              children:
                  NotificationTypeEnums.values.map((type) {
                    return SizedBox(
                      width: AppSize.size150,
                      child: RadioListTile<NotificationTypeEnums>(
                        title: Text16W500(type.title),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: type,
                        groupValue: value,
                        onChanged: (NotificationTypeEnums? newValue) {
                          if (newValue != null) {
                            selectedNotificationType.value = newValue;
                            widget.onSelected(newValue);
                          }
                        },
                      ),
                    );
                  }).toList(),
            );
          },
        ),
      ],
    );
  }
}
