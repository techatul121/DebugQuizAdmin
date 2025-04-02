import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/states/page_state.dart';

import '../../../common/utils/custom_toast.dart';
import '../../../common/utils/dialogs/custom_dialog.dart';
import '../../../common/widgets/custom_action_widget.dart';
import '../../datagrid/custom_data_grid.dart';
import '../../datagrid/custom_data_source.dart';
import '../enums/category_columns_enum.dart';
import '../models/category_model.dart';
import '../models/category_update_request_model.dart';
import '../providers/category_provider.dart';
import '../providers/delete_category_provider.dart';
import '../providers/edit_category_provider.dart';
import '../views/create_category_view.dart';
import '../views/update_category_view.dart';
import 'custom_switch_widget.dart';

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

  DataGridRow _buildRow(CategoryModel category, int index) {
    final jsonData = category.toJson();
    return DataGridRow(
      cells:
          CategoryColumnsEnum.values.map((column) {
            if (column == CategoryColumnsEnum.status) {
              return DataGridCell(
                columnName: column.key,
                value: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomSwitch(
                    value: jsonData[column.key],
                    onChanged: (value) {
                      CustomDialog.confirmDialog(
                        message:
                            'Are you sure want ${value ? "Enabled" : "Disabled"}?',
                        onConfirm: () {
                          ref
                              .read(editCategoryProvider.notifier)
                              .editCategory(
                                model: CategoryUpdateRequestModel(
                                  id: category.id,
                                  status: value,
                                ),
                              );
                        },
                      );
                    },
                  ),
                ),
              );
            } else if (column == CategoryColumnsEnum.action) {
              return DataGridCell(
                columnName: column.key,
                value: CustomActionWidget(
                  onEdit: () {
                    CustomDialog.dialog(
                      child: UpdateCategoryView(categoryModel: category),
                    );
                  },
                  onDelete: () {
                    CustomDialog.confirmDialog(
                      message: 'Are you sure want delete?',
                      onConfirm: () {
                        ref
                            .read(deleteCategoryProvider.notifier)
                            .deleteCategory(id: category.id);
                      },
                    );
                  },
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
    ref.listen(editCategoryProvider, (previous, next) {
      if (next is PageLoadingState) {
        CustomDialog.loading(message: AppStrings.loading);
      } else if (next is PageErrorState) {
        CustomToast.showError(next.exception!.message);
        CustomDialog.closeDialog();
      } else if (next is PageLoadedState) {
        CustomToast.showSuccess(next.model!.message);
        ref.invalidate(categoryProvider);
        CustomDialog.closeDialog();
        CustomDialog.closeDialog();
      }
    });

    ref.listen(deleteCategoryProvider, (previous, next) {
      if (next is PageLoadingState) {
        CustomDialog.loading(message: AppStrings.loading);
      } else if (next is PageErrorState) {
        CustomToast.showError(next.exception!.message);
        CustomDialog.closeDialog();
      } else if (next is PageLoadedState) {
        CustomToast.showSuccess(next.model!.message);
        ref.invalidate(categoryProvider);
        CustomDialog.closeDialog();
        CustomDialog.closeDialog();
      }
    });

    return CustomDataGrid(
      columns: CategoryColumnsEnum.columns,
      downloadIcon: const Icon(Icons.add_box),
      forceUpdateToPager: forceUpdateToPager,
      onDownload: () {
        CustomDialog.dialog(child: const CreateCategoryView());
      },
      pageState: pageState,
      onRefresh: () {
        ref.invalidate(categoryProvider);
      },

      onRowsPerPageChanged: (value) {
        dataSource.updateRowPerPage(value!);
      },
      data: dataSource.dataGridRow,
      columnWidthMode: ColumnWidthMode.fill,
      dataSource: dataSource,
    );
  }
}
