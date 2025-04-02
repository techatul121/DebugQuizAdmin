import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/base_response_model.dart';
import '../../../common/states/page_state.dart';
import '../../../services/remote/db/db_exports.dart';

import '../models/category_update_request_model.dart';

final editCategoryProvider =
    AutoDisposeNotifierProvider<_State, PageState<BaseResponseModel>>(
      _State.new,
    );

class _State extends AutoDisposeNotifier<PageState<BaseResponseModel>> {
  @override
  PageState<BaseResponseModel> build() {
    return PageInitialState();
  }

  Future<void> editCategory({required CategoryUpdateRequestModel model}) async {
    log('Update request model ${model.toJson()}');
    state = PageLoadingState();
    final response = await ref
        .read(dbClientProvider.notifier)
        .update(
          table: DBTablesEnum.quizCategories,
          data: model.toJson(),
          filter: ('id', model.id),
        );
    response.fold(
      (l) {
        state = PageErrorState(l);
      },
      (r) {
        state = PageLoadedState(
          BaseResponseModel(status: true, message: 'Updated successfully'),
        );
      },
    );
  }
}
