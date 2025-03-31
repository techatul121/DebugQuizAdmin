import '../../../common/enums/date_range_enums.dart';

class DataRangeModel {
  final DateRangeOptionEnums selectedRangeType;
  final DateTime? startDate;
  final DateTime? endDate;

  DataRangeModel({
    required this.selectedRangeType,
    this.startDate,
    this.endDate,
  });
}
