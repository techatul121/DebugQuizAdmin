import '../../../common/enums/notification_type_enums.dart';

class SendNotificationRequestModel {
  final String imageUrl;
  final String title;
  final String body;
  final NotificationTypeEnums notificationType;

  SendNotificationRequestModel({
    required this.imageUrl,
    required this.title,
    required this.body,
    required this.notificationType,
  });

  factory SendNotificationRequestModel.fromJson(Map<String, dynamic> json) =>
      SendNotificationRequestModel(
        imageUrl: json['image_url'],
        title: json['title'],
        body: json['body'],
        notificationType: json['notification_type'],
      );

  Map<String, dynamic> toJson() => {
    'image_url': imageUrl,
    'title': title,
    'body': body,
    'notification_type': notificationType.value,
  };
}
