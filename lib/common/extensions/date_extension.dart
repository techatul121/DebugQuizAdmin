import 'package:intl/intl.dart';

import '../enums/date_range_enums.dart';

/// Timer formatter
extension DateFormatter on DateTime {
  String get formatDate => DateFormat('dd-MM-yyyy').format(this);

  String get utcToLocalFormatter =>
      DateFormat('dd/MM/yyyy HH:MM a').format(toLocal());

  String get localToUtcFormatter => toUtc().toIso8601String();
}

extension DateRangeExtension on DateRangeOptionEnums {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Map<String, DateTime?> getDateRange({
    DateTime? customStart,
    DateTime? customEnd,
  }) {
    DateTime? startDate;
    DateTime? endDate = now;

    switch (this) {
      case DateRangeOptionEnums.thisWeek:
        startDate = now.subtract(Duration(days: now.weekday - 1));
        endDate = startDate.add(const Duration(days: 6));
        break;
      case DateRangeOptionEnums.lastWeek:
        startDate = now.subtract(const Duration(days: 7));

        break;
      case DateRangeOptionEnums.thisMonth:
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 0);
        break;
      case DateRangeOptionEnums.lastMonth:
        startDate = DateTime(now.year, now.month - 1, 1);
        endDate = DateTime(now.year, now.month, 0);
        break;

      case DateRangeOptionEnums.thisYear:
        startDate = DateTime(now.year, 1, 1);
        break;
      case DateRangeOptionEnums.lastYear:
        startDate = DateTime(now.year - 1, 1, 1);
        endDate = DateTime(now.year - 1, 12, 31);
        break;
      case DateRangeOptionEnums.allTime:
        startDate = null;
        endDate = null;
        break;
      case DateRangeOptionEnums.custom:
        if (customStart != null && customEnd != null) {
          startDate = customStart;
          endDate = customEnd;
        } else {
          throw ArgumentError('Custom date range requires start and end dates');
        }
        break;
    }

    return {
      'start_date':
          startDate != null
              ? DateTime.parse(formatter.format(startDate))
              : null,
      'end_date':
          endDate != null ? DateTime.parse(formatter.format(endDate)) : null,
    };
  }
}
