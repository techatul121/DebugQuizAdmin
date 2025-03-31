import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/extensions/strings_extensions.dart';
import '../../datagrid/custom_column_label.dart';

enum NotificationColumnsEnum {
  indexColumn(key: 'index', title: AppStrings.index),
  createAt(key: 'created_at', title: AppStrings.createAtColumn),
  notificationTitle(key: 'title', title: AppStrings.titleColumn),
  body(key: 'body', title: AppStrings.body),
  notificationType(
    key: 'notification_type',
    title: AppStrings.notificationTypeColumn,
    columnWidthMode: ColumnWidthMode.fill,
  );

  const NotificationColumnsEnum({
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
