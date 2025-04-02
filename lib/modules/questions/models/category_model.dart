import 'dart:convert';

import '../../../common/extensions/date_extension.dart';
import '../enums/category_columns_enum.dart';
import '../enums/category_type_enum.dart';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final int id;
  final CategoryTypeEnum categoryType;
  final String name;
  final bool status;
  final DateTime createAt;
  CategoryModel({
    required this.id,
    required this.categoryType,
    required this.name,
    required this.status,
    required this.createAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    categoryType: CategoryTypeEnum.values.firstWhere(
      (e) => e.toString().split('.').last == json[CategoryColumnsEnum.type.key],
    ),
    name: json[CategoryColumnsEnum.name.key],
    status: json[CategoryColumnsEnum.status.key],
    createAt: DateTime.parse(json[CategoryColumnsEnum.createAt.key]),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    CategoryColumnsEnum.type.key: categoryType.toString().split('.').last,
    CategoryColumnsEnum.name.key: name,
    CategoryColumnsEnum.status.key: status,
    CategoryColumnsEnum.createAt.key: createAt.utcToLocalFormatter,
  };
}
