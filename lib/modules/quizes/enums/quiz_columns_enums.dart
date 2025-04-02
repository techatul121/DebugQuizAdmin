import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/extensions/strings_extensions.dart';
import '../../datagrid/custom_column_label.dart';

enum QuizColumnsEnum {
  indexColumn(key: 'index', title: AppStrings.index),
  createAt(key: 'created_at', title: AppStrings.createAtColumn),
  quizTitle(key: 'title', title: AppStrings.titleColumn),
  totalTime(key: 'time_limit', title: AppStrings.totalTime),
  quizType(key: 'quiz_type', title: AppStrings.quizTypeColumn),
  shortDescription(
    key: 'short_description',
    title: AppStrings.shortDescriptionColumn,
  ),
  categoryName(key: 'category_name', title: AppStrings.categoryNameColumn),
  status(key: 'status', title: AppStrings.status),

  action(
    key: 'action',
    title: AppStrings.actionColumn,
    columnWidthMode: ColumnWidthMode.auto,
  );

  const QuizColumnsEnum({
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
