import 'dart:convert';

import '../../../common/extensions/date_extension.dart';
import '../enums/quiz_columns_enums.dart';
import '../enums/quiz_type_enum.dart';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  final int id;
  final String title;
  final DateTime createdAt;
  final String shortDescription;
  final int timeLimit;
  final int categoryId;
  final String categoryName;
  final bool status;
  final QuizTypeEnum quizType;

  QuizModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.shortDescription,
    required this.timeLimit,
    required this.categoryId,
    required this.status,
    required this.categoryName,
    required this.quizType,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    id: json['id'],
    title: json[QuizColumnsEnum.quizTitle.key],
    createdAt: DateTime.parse(json[QuizColumnsEnum.createAt.key]),
    shortDescription: json[QuizColumnsEnum.shortDescription.key],
    timeLimit: json[QuizColumnsEnum.totalTime.key],
    categoryId: json['category_id'],
    categoryName: json[QuizColumnsEnum.categoryName.key],
    status: json[QuizColumnsEnum.status.key],
    quizType: QuizTypeEnum.values.firstWhere(
      (e) => e.toString().split('.').last == json[QuizColumnsEnum.quizType.key],
    ),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    QuizColumnsEnum.quizTitle.key: title,
    QuizColumnsEnum.createAt.key: createdAt.utcToLocalFormatter,
    QuizColumnsEnum.shortDescription.key: shortDescription,
    QuizColumnsEnum.totalTime.key: timeLimit,
    'category_id': categoryId,
    QuizColumnsEnum.status.key: status,
    QuizColumnsEnum.categoryName.key: categoryName,
    QuizColumnsEnum.quizType.key: quizType.name,
  };
}
