import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/constants/image_path_constants.dart';
import '../../../common/enums/date_range_enums.dart';
import '../../../common/extensions/context_extensions.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_geometry.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/utils/custom_toast.dart';
import '../../../common/utils/dialogs/custom_dialog.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../common/widgets/custom_svg.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../provider/date_range_picker_provider.dart';

class CustomDateRangePickerWidget extends StatelessWidget {
  const CustomDateRangePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceWidth * 0.3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SBH10(),
          Padding(
            padding: AppEdgeInsets.h10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text16W500(AppStrings.selectDuration),
                IconButton(
                  onPressed: () {
                    CustomDialog.closeDialog();
                  },
                  icon: const CustomSvg(assetName: SvgImages.closeIcon),
                ),
              ],
            ),
          ),
          const SBH10(),
          SfDateRangePickerTheme(
            data: SfDateRangePickerThemeData(
              headerTextStyle: context.textTheme.bodyLarge!.copyWith(
                fontSize: AppSize.size20,
              ),
              backgroundColor: AppColors.white,
              viewHeaderTextStyle: context.textTheme.labelLarge!.copyWith(
                color: AppColors.blue,
                fontSize: AppSize.size18,
              ),
              headerBackgroundColor: AppColors.white,
              cellTextStyle: context.textTheme.bodyMedium,
              leadingCellTextStyle: context.textTheme.titleLarge,
              weekNumberTextStyle: context.textTheme.titleLarge!.copyWith(
                color: AppColors.blue,
              ),
              rangeSelectionColor: AppColors.highlightColor,
            ),
            child: Consumer(
              builder: (context, ref, child) {
                return SfDateRangePicker(
                  showNavigationArrow: true,
                  headerStyle: const DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                  ),
                  showActionButtons: true,
                  onSubmit: (value) {
                    if (value != null) {
                      final startDate = (value as PickerDateRange).startDate;
                      final endDate = value.endDate;
                      if (startDate != null && endDate != null) {
                        log(
                          'Selected custom date ==> Start date ${value.startDate} End date ${(value).endDate}',
                        );
                        ref
                            .read(dateRangePickerProvider.notifier)
                            .getDateRange(
                              selectDateRangeOption:
                                  DateRangeOptionEnums.custom,
                              customStart: startDate,
                              customEnd: endDate,
                            );

                        CustomDialog.closeDialog();
                      } else {
                        CustomToast.showError(AppStrings.validDate);
                      }
                    } else {
                      CustomToast.showError(
                        AppStrings.selectBothStartAndEndDate,
                      );
                    }
                  },
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  onCancel: () {
                    CustomDialog.closeDialog();
                  },
                  selectionMode: DateRangePickerSelectionMode.range,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
