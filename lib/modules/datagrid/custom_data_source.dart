import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../common/theme/app_colors.dart';
import '../../common/theme/app_size.dart';
import '../../common/widgets/custom_text_form_field.dart';

import '../../common/widgets/custom_text_widget.dart';
import 'custom_cell_widget.dart';

class CustomDataSource<T> extends DataGridSource {
  CustomDataSource({
    this.editableColumns = const {},
    this.onValueChanged,
    this.inputFormatters,
    this.tappableUnderlineColumn = const {},
    this.greenColumns = const {},
    this.redColumns = const {},
    this.forceUpdateToGrid,
    this.onTapUnderlineText,
  });

  final Set<String> editableColumns;
  final Set<String> redColumns;
  final Set<String> greenColumns;
  final Set<String> tappableUnderlineColumn;
  final void Function(String columnName, int rowIndex, String newValue)?
  onValueChanged;
  List<TextInputFormatter>? inputFormatters;
  dynamic newCellValue;
  final void Function()? forceUpdateToGrid;
  int _rowPerPage = 20;
  final void Function(String columnName, int rowIndex)? onTapUnderlineText;

  @override
  List<DataGridRow> get rows => dataGridRow;
  List<DataGridRow> dataGridRow = [];

  /// Method to update source
  void updateSource() {
    notifyDataSourceListeners();
  }

  Color getBackgroundColor(DataGridRow row) {
    int index =
        effectiveRows.isEmpty
            ? dataGridRow.indexOf(row) + 1
            : effectiveRows.indexOf(row);
    if (index % 2 != 0) {
      return AppColors.blue.withValues(alpha: 0.1);
    } else {
      return AppColors.white;
    }
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int dataRowIndex = rows.indexOf(row);
    return DataGridRowAdapter(
      color: getBackgroundColor(row),
      cells: row
          .getCells()
          .map((cell) {
            final isEditable = editableColumns.contains(cell.columnName);
            final isTappable = tappableUnderlineColumn.contains(
              cell.columnName,
            );
            final isRedColumn = redColumns.contains(cell.columnName);
            final isGreenColumn = greenColumns.contains(cell.columnName);
            return isEditable
                ? _buildEditWidget(cell, dataRowIndex)
                : isTappable
                ? _buildTappableUnderlineWidget(cell, dataRowIndex)
                : (cell.value is Widget
                    ? UnconstrainedBox(child: cell.value)
                    : CustomCellWidget(
                      cellValue: cell.value,
                      alignment:
                          cell.columnName == 'index'
                              ? Alignment.centerLeft
                              : null,
                      color:
                          isRedColumn
                              ? AppColors.red
                              : isGreenColumn
                              ? AppColors.green
                              : null,
                    ));
          })
          .toList(growable: false),
    );
  }

  /// The reason behind using [TextEditingController] is that  real update
  final Map<int, TextEditingController> _controllers = {};

  Widget _buildEditWidget(DataGridCell<dynamic> cell, int dataRowIndex) {
    if (!_controllers.containsKey(dataRowIndex)) {
      _controllers[dataRowIndex] = TextEditingController();
    }
    final controller = _controllers[dataRowIndex]!;

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: AppSize.size40,
        child: CustomTextFormField(
          controller: controller..text = cell.value.toString(),
          inputFormatters: inputFormatters,
          heightTextFormField: AppSize.size40,
          autofocus: false,
          onChanged: (newValue) {
            newCellValue =
                newValue.isNotEmpty ? newValue : cell.value.toString();

            onValueChanged?.call(cell.columnName, dataRowIndex, newCellValue);
          },
        ),
      ),
    );
  }

  int initialLoadCount = 30;

  List<DataGridRow> fullData = []; // Store the complete dataset

  Widget _buildTappableUnderlineWidget(DataGridCell cell, int dataRowIndex) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(height: AppSize.size40, child: const Text16W500('text')),
    );
  }

  Future<void> createRows(
    List<DataGridRow> data, {
    int initialLoadCount = 30,
  }) async {
    fullData = data; // Store the entire dataset
    dataGridRow.clear();

    // Load only the initial set of rows
    // dataGridRow.addAll(fullData.take(initialLoadCount));

    dataGridRow.addAll(fullData.take(initialLoadCount));
    updateSource();
    if (dataGridRow.length < data.length) {
      await Future.delayed(Durations.short1);
      dataGridRow.addAll(fullData.skip(initialLoadCount));
      updateSource();

      forceUpdateToGrid?.call();
    }
  }

  void resetSource() {
    dataGridRow.clear();
    updateSource();
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    _controllers.clear();
    super.dispose();
  }

  void updateRowPerPage(int rowPerPage) {
    _rowPerPage = rowPerPage;
  }

  double getPageCount() {
    final rowsCount =
        filterConditions.isNotEmpty ? effectiveRows.length : dataGridRow.length;

    return (rowsCount / _rowPerPage).ceilToDouble();
  }
}
