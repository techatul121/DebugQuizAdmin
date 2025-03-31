import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/constants/image_path_constants.dart';
import '../../../common/enums/date_range_enums.dart';
import '../../../common/extensions/date_extension.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_geometry.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/utils/dialogs/custom_dialog.dart';

import '../../../common/widgets/custom_drop_down_menu.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../common/widgets/custom_text_widget.dart';

import '../provider/date_range_picker_provider.dart';

import '../widgets/custom_date_range_picker_widget.dart';

import '../widgets/user_count_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const String path = '/dashboard';
  static const String name = 'dashboard';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text36W400(AppStrings.dashboard),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final selectedDateRange = ref.watch(dateRangePickerProvider);
                return CustomDropDownMenu<String>(
                  hintText: AppStrings.selectDate,
                  width: AppSize.size300,
                  readOnly: true,
                  initialValue:
                      selectedDateRange.selectedRangeType ==
                              DateRangeOptionEnums.custom
                          ? '${selectedDateRange.startDate!.formatDate} To ${selectedDateRange.endDate!.formatDate}'
                          : selectedDateRange.selectedRangeType.value,
                  iconColor: AppColors.white,
                  customInitialValue:
                      selectedDateRange.selectedRangeType ==
                      DateRangeOptionEnums.custom,
                  borderRadius: AppBorderRadius.a10,
                  fillColor: AppColors.blue,
                  textColor: AppColors.white,
                  onSelect: (value) {
                    final selectedOption =
                        DateRangeOptionEnums.values
                            .where((e) => e.value == value)
                            .first;
                    if (selectedOption == DateRangeOptionEnums.custom) {
                      CustomDialog.showCustomDialog(
                        child: const CustomDateRangePickerWidget(),
                      );
                    } else {
                      ref
                          .read(dateRangePickerProvider.notifier)
                          .getDateRange(selectDateRangeOption: selectedOption);
                    }
                  },
                  initialItems:
                      DateRangeOptionEnums.values
                          .map(
                            (e) => CustomDropDownMenuItem<String>(
                              value: e.value,
                              label: e.title,
                            ),
                          )
                          .toList(),
                );
              },
            ),
          ],
        ),
        const SBH30(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSize.size20,
          children: [
            Expanded(
              child: Column(
                spacing: AppSize.size20,
                children: [
                  Row(
                    spacing: AppSize.size20,
                    children: [
                      const Expanded(
                        child: UserCountCard(
                          assetName: SvgImages.peopleIcon,
                          title: '12',
                          count: 'Total Users',
                        ),
                      ),
                      const Expanded(
                        child: UserCountCard(
                          assetName: SvgImages.personalCardIcon,
                          title: '118',
                          count: 'Active users',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
