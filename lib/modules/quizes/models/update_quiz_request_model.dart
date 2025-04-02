import '../../../common/extensions/json_extensions.dart';
import '../enums/quiz_type_enum.dart';

class UpdateQuizRequestModel {
  final int id;
  final String? title;
  final String? shortDescription;
  final int? timeLimit;
  final int? categoryId;
  final QuizTypeEnum? quizTypeEnum;
  final bool? status;
  UpdateQuizRequestModel({
    this.title,
    this.shortDescription,
    this.timeLimit,
    this.categoryId,
    this.quizTypeEnum,
    required this.id,
    this.status,
  });

  factory UpdateQuizRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateQuizRequestModel(
        id: json['id'],
        title: json['title'],
        shortDescription: json['short_description'],
        timeLimit: json['time_limit'],
        categoryId: json['category_id'],
        quizTypeEnum: QuizTypeEnum.free,
      );

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'short_description': shortDescription,
        'time_limit': timeLimit,
        'category_id': categoryId,
        'quiz_type': quizTypeEnum?.name,
        'status': status,
      }.removeNullOrEmpty();
}
