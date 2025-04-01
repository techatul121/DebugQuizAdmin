import 'dart:convert';

CategoryRequestModel categoryRequestModelFromJson(String str) =>
    CategoryRequestModel.fromJson(json.decode(str));

String categoryRequestModelToJson(CategoryRequestModel data) =>
    json.encode(data.toJson());

class CategoryRequestModel {
  final String categoryType;
  final String name;

  CategoryRequestModel({required this.categoryType, required this.name});

  factory CategoryRequestModel.fromJson(Map<String, dynamic> json) =>
      CategoryRequestModel(
        categoryType: json['category_type'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
    'category_type': categoryType,
    'name': name,
  };
}
