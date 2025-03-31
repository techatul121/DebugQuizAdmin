import 'package:flutter/material.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../widgets/notification_data_grid.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  static const String path = '/notifications';
  static const String name = 'notifications';

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSize.size20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text36W400(AppStrings.notifications),
        Expanded(child: NotificationDataGrid()),
      ],
    );
  }
}
