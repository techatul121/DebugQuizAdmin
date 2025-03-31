import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/enums/date_range_enums.dart';
import '../../../common/extensions/date_extension.dart';
import '../model/data_range_model.dart';

class _State extends AutoDisposeNotifier<DataRangeModel> {
  @override
  DataRangeModel build() {
    state = DataRangeModel(selectedRangeType: DateRangeOptionEnums.allTime);
    getDateRange(selectDateRangeOption: DateRangeOptionEnums.allTime);

    return state;
  }

  Future<void> getDateRange({
    required DateRangeOptionEnums selectDateRangeOption,
    DateTime? customStart,
    DateTime? customEnd,
  }) async {
    await Future.delayed(Duration.zero);
    final Map<String, DateTime?> response = selectDateRangeOption.getDateRange(
      customStart: customStart,
      customEnd: customEnd,
    );

    state = DataRangeModel(
      selectedRangeType: selectDateRangeOption,
      startDate: response['start_date'],
      endDate: response['end_date'],
    );
    debugPrint('Type of date Response  state $state');
  }
}

final dateRangePickerProvider =
    AutoDisposeNotifierProvider<_State, DataRangeModel>(_State.new);
