import '../../../common/extensions/json_extensions.dart';

class DashboardRequestModel {
  final DateTime? startDate;
  final DateTime? endDate;

  DashboardRequestModel({required this.startDate, required this.endDate});

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate?.toIso8601String() ?? '',
      'end_date': endDate?.toIso8601String() ?? '',
    }.removeNullOrEmpty();
  }
}
