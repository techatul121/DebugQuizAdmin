import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../common/extensions/context_extensions.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_size.dart';

import '../../common/states/page_state.dart';
import '../../common/theme/app_geometry.dart';
import '../../common/widgets/custom_circular_progress_indicator.dart';
import '../../common/widgets/custom_floating_button.dart';
import '../../common/widgets/custom_sized_box.dart';

import 'custom_data_grid_error_view.dart';
import 'custom_data_source.dart';

class CustomDataGrid<T> extends StatefulWidget {
  final List<GridColumn> columns;
  final List<T> data;
  final CustomDataSource<T> dataSource;
  final bool allowSorting;
  final bool showPagination;
  final bool allowFiltering;
  final bool allowEditing;
  final int rowsPerPage;
  final bool verticalScrollEnable;
  final bool expanded;
  final DataGridController? dataGridController;
  final Function(T data)? onRowTap;
  final ColumnWidthMode? columnWidthMode;
  final double? height;
  final GlobalKey<SfDataGridState>? sfGridKey;
  final VoidCallback? onDownload;
  final Widget? downloadIcon;
  final Widget? footer;
  final void Function(int?)? onRowsPerPageChanged;
  final ValueNotifier<PageState>? pageState;
  final ValueNotifier<bool>? forceUpdateToPager;
  final VoidCallback? onRefresh;

  const CustomDataGrid({
    super.key,
    required this.columns,
    required this.data,
    this.allowSorting = true,
    this.showPagination = true,
    this.allowFiltering = true,
    this.allowEditing = false,
    this.expanded = true,
    this.rowsPerPage = 20,
    required this.dataSource,
    this.onRowTap,
    this.verticalScrollEnable = true,
    this.height,
    this.columnWidthMode,
    this.forceUpdateToPager,
    this.sfGridKey,
    this.dataGridController,
    this.onDownload,
    this.footer,
    this.downloadIcon,
    this.onRowsPerPageChanged,
    this.pageState,
    this.onRefresh,
  });

  @override
  State<CustomDataGrid<T>> createState() => _CustomDataGridState<T>();
}

class _CustomDataGridState<T> extends State<CustomDataGrid<T>> {
  final _rowIndex = ValueNotifier(0);
  late DataPagerController pagerController;

  @override
  void initState() {
    super.initState();
    _rowIndex.value = widget.rowsPerPage;
    pagerController = DataPagerController();
  }

  @override
  void dispose() {
    _rowIndex.dispose();
    pagerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget dataGrid = Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blue),
        borderRadius: AppBorderRadius.a10,
      ),
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: AppColors.blue,
          sortIconColor: AppColors.white,
          gridLineColor: AppColors.blue,
          currentCellStyle: const DataGridCurrentCellStyle(
            borderColor: AppColors.transparent,
            borderWidth: 1,
          ),
          selectionColor: AppColors.transparent,
          filterPopupDisabledTextStyle: context.textTheme.titleMedium!.copyWith(
            fontSize: AppSize.size18,
          ),
          filterPopupTextStyle: context.textTheme.titleMedium!.copyWith(
            fontSize: AppSize.size18,
          ),
          filterIconHoverColor: AppColors.white,
          filterIconColor: AppColors.white,
        ),
        child: ValueListenableBuilder(
          valueListenable: _rowIndex,
          builder: (context, value, child) {
            return SfDataGrid(
              key: widget.sfGridKey,
              source: widget.dataSource,
              columns: widget.columns,
              allowEditing: widget.allowEditing,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              allowSorting: widget.allowSorting,
              allowFiltering: widget.allowFiltering,
              verticalScrollPhysics:
                  widget.verticalScrollEnable
                      ? const AlwaysScrollableScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
              gridLinesVisibility: GridLinesVisibility.none,
              headerGridLinesVisibility: GridLinesVisibility.none,
              columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
              controller: widget.dataGridController,
              columnWidthMode:
                  widget.columnWidthMode ?? ColumnWidthMode.fitByColumnName,
              shrinkWrapRows: true,
              allowTriStateSorting: true,
              onFilterChanged: (details) {
                setState(() {
                  widget.dataSource.getPageCount();
                });
              },
              onQueryRowHeight:
                  (details) => details.getIntrinsicRowHeight(details.rowIndex),
              rowsPerPage: value,
              onCellTap: (details) {
                if (details.rowColumnIndex.rowIndex != 0) {
                  final int rowIndex = details.rowColumnIndex.rowIndex;
                  widget.onRowTap?.call(widget.data[rowIndex - 1]);
                }
              },
            );
          },
        ),
      ),
    );

    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        widget.expanded ? Expanded(child: dataGrid) : dataGrid,
        if (widget.showPagination) ...[
          const SBH10(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...[
                ValueListenableBuilder(
                  valueListenable: widget.pageState!,
                  builder: (context, value, child) {
                    if (value is PageInitialState) {
                      return const Spacer();
                    } else if (value is PageLoadingState) {
                      return const Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: UnconstrainedBox(child: CPI()),
                        ),
                      );
                    } else if (value is PageErrorState) {
                      return Expanded(
                        child: CustomDataGridErrorView(
                          exception: value.exception!,
                          onRefresh: widget.onRefresh,
                        ),
                      );
                    } else if (value is PageLoadedState) {
                      return Expanded(
                        child: SfDataPagerTheme(
                          data: SfDataPagerThemeData(
                            itemBorderRadius: AppBorderRadius.a10,
                            dropdownButtonBorderColor: AppColors.blue
                                .withValues(alpha: 0.6),
                            disabledItemColor: AppColors.blue.withValues(
                              alpha: 0.2,
                            ),
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: _rowIndex,
                            builder: (context, updatedValue, child) {
                              return ValueListenableBuilder(
                                valueListenable:
                                    widget.forceUpdateToPager ??
                                    ValueNotifier(false),
                                builder: (context, value, child) {
                                  return SfDataPager(
                                    visibleItemsCount: 5,
                                    availableRowsPerPage: [20, 50, 100],
                                    onRowsPerPageChanged: (value) {
                                      if (value != null) {
                                        _rowIndex.value = value;
                                        widget.onRowsPerPageChanged?.call(
                                          value,
                                        );
                                      }
                                    },
                                    pageCount: widget.dataSource.getPageCount(),
                                    delegate: widget.dataSource,
                                    controller: pagerController,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],

              if (widget.footer != null) ...[widget.footer!],

              if (widget.footer == null)
                CustomAddFloatingButton(
                  icons: widget.downloadIcon!,
                  onTap: () {
                    widget.onDownload?.call();
                  },
                ),
            ],
          ),
        ],
      ],
    );
  }
}
