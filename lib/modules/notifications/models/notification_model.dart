import '../../../common/enums/notification_type_enums.dart';
import '../../../common/extensions/date_extension.dart';
import '../enums/notification_columns_enum.dart';

class NotificationModel {
  final int id;
  final DateTime createdAt;
  final String title;
  final String body;
  final NotificationTypeEnums notificationTypeEnums;

  NotificationModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.notificationTypeEnums,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      createdAt: DateTime.parse(json[NotificationColumnsEnum.createAt.key]),
      title: json[NotificationColumnsEnum.notificationTitle.key],
      body: json[NotificationColumnsEnum.body.key],
      notificationTypeEnums: NotificationTypeEnums.values.firstWhere(
        (e) => e.name == json[NotificationColumnsEnum.notificationType.key],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NotificationColumnsEnum.createAt.key: createdAt.utcToLocalFormatter,
      NotificationColumnsEnum.notificationTitle.key: title,
      NotificationColumnsEnum.body.key: body,
      NotificationColumnsEnum.notificationType.key: notificationTypeEnums.title,
    };
  }
}
