import '../../../common/extensions/json_extensions.dart';
import '../enums/category_columns_enum.dart';
import '../enums/category_type_enum.dart';

class CategoryUpdateRequestModel {
  final int id;
  final CategoryTypeEnum? categoryType;
  final String? name;
  bool? status;

  CategoryUpdateRequestModel({
    required this.id,
    this.categoryType,
    this.name,
    this.status,
  });

  Map<String, dynamic> toJson() =>
      {
        CategoryColumnsEnum.type.key: categoryType?.name,
        CategoryColumnsEnum.name.key: name,
        CategoryColumnsEnum.status.key: status,
      }.removeNullOrEmpty();
}
