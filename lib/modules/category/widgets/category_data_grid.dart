import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../common/states/page_state.dart';

import '../../../common/theme/app_colors.dart';
import '../../datagrid/custom_data_grid.dart';
import '../../datagrid/custom_data_source.dart';
import '../enums/category_columns_enum.dart';
import '../models/category_model.dart';
import '../providers/category_provider.dart';

class CategoryDataGrid extends ConsumerStatefulWidget {
  const CategoryDataGrid({super.key});

  @override
  ConsumerState<CategoryDataGrid> createState() => _CategoryDataGridState();
}

class _CategoryDataGridState extends ConsumerState<CategoryDataGrid> {
  late CustomDataSource<CategoryModel> dataSource;
  final pageState = ValueNotifier<PageState<List<CategoryModel>>>(
    PageLoadingState(),
  );
  final forceUpdateToPager = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    dataSource = CustomDataSource<CategoryModel>(
      forceUpdateToGrid: () {
        forceUpdateToPager.value = true;
      },
    );
  }

  DataGridRow _buildRow(CategoryModel notification, int index) {
    final jsonData = notification.toJson();
    return DataGridRow(
      cells:
          CategoryColumnsEnum.values.map((column) {
            if (column == CategoryColumnsEnum.status) {
              return DataGridCell(
                columnName: column.key,
                value: Switch(
                  hoverColor: AppColors.transparent,

                  value: jsonData[column.key],
                  onChanged: (value) {},
                ),
              );
            } else {
              return DataGridCell(
                columnName: column.key,
                value:
                    column == CategoryColumnsEnum.indexColumn
                        ? index
                        : jsonData[column.key],
              );
            }
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
    ref.listen(categoryProvider, (previous, next) {
      pageState.value = next;
      forceUpdateToPager.value = false;

      if (next is PageLoadedState) {
        dataSource.createRows(
          next.model!.asMap().entries.map((entry) {
            return _buildRow(entry.value, entry.key + 1);
          }).toList(),
        );
      } else {
        dataSource.resetSource();
      }
    });

    return CustomDataGrid(
      columns: CategoryColumnsEnum.columns,
      downloadIcon: const Icon(Icons.add_box),
      forceUpdateToPager: forceUpdateToPager,
      onDownload: () {},
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
