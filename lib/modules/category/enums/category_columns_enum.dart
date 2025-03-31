import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/extensions/strings_extensions.dart';
import '../../datagrid/custom_column_label.dart';

enum CategoryColumnsEnum {
  indexColumn(key: 'index', title: AppStrings.index),
  createAt(key: 'created_at', title: AppStrings.createAtColumn),
  name(key: 'name', title: AppStrings.nameColumn),
  type(key: 'category_type', title: AppStrings.typeColumn),

  status(key: 'status', title: AppStrings.status);

  const CategoryColumnsEnum({
    required this.key,
    required this.title,

    this.columnWidthMode = ColumnWidthMode.none,
  });

  final String key;
  final String title;

  final ColumnWidthMode columnWidthMode;

  static get columns =>
      values
          .map(
            (e) => GridColumn(
              columnName: e.key,
              filterPopupMenuOptions: const FilterPopupMenuOptions(
                showColumnName: false,
              ),
              label: CustomColumnLabel(title: e.title.toTitleCase()),

              columnWidthMode: e.columnWidthMode,
            ),
          )
          .toList();
}
