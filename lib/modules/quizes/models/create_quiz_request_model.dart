import 'dart:convert';

import '../enums/quiz_type_enum.dart';

CreateQuizRequestModel createQuizRequestModelFromJson(String str) =>
    CreateQuizRequestModel.fromJson(json.decode(str));

String createQuizRequestModelToJson(CreateQuizRequestModel data) =>
    json.encode(data.toJson());

class CreateQuizRequestModel {
  final String title;
  final String shortDescription;
  final int timeLimit;
  final int categoryId;
  final QuizTypeEnum quizTypeEnum;
  CreateQuizRequestModel({
    required this.title,
    required this.shortDescription,
    required this.timeLimit,
    required this.categoryId,
    required this.quizTypeEnum,
  });

  factory CreateQuizRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateQuizRequestModel(
        title: json['title'],
        shortDescription: json['short_description'],
        timeLimit: json['time_limit'],
        categoryId: json['category_id'],
        quizTypeEnum: QuizTypeEnum.free,
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'short_description': shortDescription,
    'time_limit': timeLimit,
    'category_id': categoryId,
    'quiz_type': quizTypeEnum.name,
  };
}
