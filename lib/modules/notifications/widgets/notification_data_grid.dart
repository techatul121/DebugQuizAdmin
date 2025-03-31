import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../common/states/page_state.dart';
import '../../../common/utils/bottom_sheets/custom_bottom_sheet.dart';
import '../../datagrid/custom_data_grid.dart';
import '../../datagrid/custom_data_source.dart';
import '../enums/notification_columns_enum.dart';
import '../models/notification_model.dart';

import '../views/create_notification_view.dart';

class NotificationDataGrid extends ConsumerStatefulWidget {
  const NotificationDataGrid({super.key});

  @override
  ConsumerState<NotificationDataGrid> createState() =>
      _NotificationDataGridState();
}

class _NotificationDataGridState extends ConsumerState<NotificationDataGrid> {
  late CustomDataSource<NotificationModel> dataSource;
  final pageState = ValueNotifier<PageState<List<NotificationModel>>>(
    PageLoadingState(),
  );
  final forceUpdateToPager = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    dataSource = CustomDataSource<NotificationModel>(
      forceUpdateToGrid: () {
        forceUpdateToPager.value = true;
      },
    );
  }

  DataGridRow _buildRow(NotificationModel notification, int index) {
    final jsonData = notification.toJson();
    return DataGridRow(
      cells:
          NotificationColumnsEnum.values.map((column) {
            return DataGridCell(
              columnName: column.key,
              value:
                  column == NotificationColumnsEnum.indexColumn
                      ? index
                      : jsonData[column.key],
            );
          }).toList(),
    );
  }

  @override
  void dispose() {
    pageState.dispose();
    forceUpdateToPager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDataGrid(
      columns: NotificationColumnsEnum.columns,
      downloadIcon: const Icon(Icons.add_box),
      forceUpdateToPager: forceUpdateToPager,
      onDownload: () {
        CustomBottomSheet.show(child: const CreateNotificationView());
      },
      pageState: pageState,
      onRefresh: () {},

      onRowsPerPageChanged: (value) {
        dataSource.updateRowPerPage(value!);
      },
      data: dataSource.dataGridRow,
      columnWidthMode: ColumnWidthMode.fill,
      dataSource: dataSource,
    );
  }
}
