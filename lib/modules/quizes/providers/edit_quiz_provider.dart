import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/base_response_model.dart';
import '../../../common/states/page_state.dart';
import '../../../services/remote/db/db_exports.dart';

import '../models/update_quiz_request_model.dart';

final editQuizProvider =
    AutoDisposeNotifierProvider<_State, PageState<BaseResponseModel>>(
      _State.new,
    );

class _State extends AutoDisposeNotifier<PageState<BaseResponseModel>> {
  @override
  PageState<BaseResponseModel> build() {
    return PageInitialState();
  }

  Future<void> editQuiz({required UpdateQuizRequestModel model}) async {
    log('Request ${model.toJson()}');
    state = PageLoadingState();
    final response = await ref
        .read(dbClientProvider.notifier)
        .update(
          table: DBTablesEnum.quizzes,
          data: model.toJson(),
          filter: ('id', model.id),
        );
    log('Response $response');
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
