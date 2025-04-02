import 'dart:developer';

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

import '../enums/quiz_columns_enums.dart';

import '../models/quiz_model.dart';

import '../models/update_quiz_request_model.dart';
import '../providers/delete_quiz_provider.dart';

import '../providers/edit_quiz_provider.dart';
import '../providers/quiz_provider.dart';
import '../views/create_quiz_view.dart';

import '../views/update_quiz_view.dart';
import 'custom_switch_widget.dart';

class QuizDataGrid extends ConsumerStatefulWidget {
  const QuizDataGrid({super.key});

  @override
  ConsumerState<QuizDataGrid> createState() => _QuizDataGridState();
}

class _QuizDataGridState extends ConsumerState<QuizDataGrid> {
  late CustomDataSource<QuizModel> dataSource;
  final pageState = ValueNotifier<PageState<List<QuizModel>>>(
    PageLoadingState(),
  );
  final forceUpdateToPager = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    dataSource = CustomDataSource<QuizModel>(
      forceUpdateToGrid: () {
        forceUpdateToPager.value = true;
      },
    );
  }

  DataGridRow _buildRow(QuizModel quiz, int index) {
    final jsonData = quiz.toJson();
    return DataGridRow(
      cells:
          QuizColumnsEnum.values.map((column) {
            if (column == QuizColumnsEnum.status) {
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
                              .read(editQuizProvider.notifier)
                              .editQuiz(
                                model: UpdateQuizRequestModel(
                                  id: quiz.id,
                                  status: value,
                                ),
                              );
                        },
                      );
                    },
                  ),
                ),
              );
            } else if (column == QuizColumnsEnum.action) {
              return DataGridCell(
                columnName: column.key,
                value: CustomActionWidget(
                  onEdit: () {
                    CustomDialog.dialog(child: UpdateQuizView(quizModel: quiz));
                  },
                  onDelete: () {
                    CustomDialog.confirmDialog(
                      message: 'Are you sure want delete?',
                      onConfirm: () {
                        ref
                            .read(deleteQuizProvider.notifier)
                            .deleteQuiz(id: quiz.id);
                      },
                    );
                  },
                ),
              );
            } else {
              return DataGridCell(
                columnName: column.key,
                value:
                    column == QuizColumnsEnum.indexColumn
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
    ref.listen(quizProvider, (previous, next) {
      log('Api call for quiz read');
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
    ref.listen(editQuizProvider, (previous, next) {
      if (next is PageLoadingState) {
        CustomDialog.loading(message: AppStrings.loading);
      } else if (next is PageErrorState) {
        CustomToast.showError(next.exception!.message);
        CustomDialog.closeDialog();
      } else if (next is PageLoadedState) {
        CustomToast.showSuccess(next.model!.message);
        ref.invalidate(quizProvider);
        CustomDialog.closeDialog();
        CustomDialog.closeDialog();
      }
    });

    ref.listen(deleteQuizProvider, (previous, next) {
      if (next is PageLoadingState) {
        CustomDialog.loading(message: AppStrings.loading);
      } else if (next is PageErrorState) {
        CustomToast.showError(next.exception!.message);
        CustomDialog.closeDialog();
      } else if (next is PageLoadedState) {
        CustomToast.showSuccess(next.model!.message);
        ref.invalidate(quizProvider);
        CustomDialog.closeDialog();
        CustomDialog.closeDialog();
      }
    });

    return CustomDataGrid(
      columns: QuizColumnsEnum.columns,
      downloadIcon: const Icon(Icons.add_box),
      forceUpdateToPager: forceUpdateToPager,
      onDownload: () {
        CustomDialog.dialog(child: const CreateQuizView());
      },
      pageState: pageState,
      onRefresh: () {
        ref.invalidate(quizProvider);
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
