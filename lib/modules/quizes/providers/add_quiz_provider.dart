import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/base_response_model.dart';
import '../../../common/states/page_state.dart';
import '../../../services/remote/db/db_exports.dart';

import '../models/create_quiz_request_model.dart';

final addQuizProvider =
    AutoDisposeNotifierProvider<_State, PageState<BaseResponseModel>>(
      _State.new,
    );

class _State extends AutoDisposeNotifier<PageState<BaseResponseModel>> {
  @override
  PageState<BaseResponseModel> build() {
    return PageInitialState();
  }

  Future<void> addQuiz({required CreateQuizRequestModel model}) async {
    state = PageLoadingState();
    final response = await ref
        .read(dbClientProvider.notifier)
        .create(table: DBTablesEnum.quizzes, data: model.toJson());
    response.fold(
      (l) {
        state = PageErrorState(l);
      },
      (r) {
        state = PageLoadedState(
          BaseResponseModel(status: true, message: 'Added successfully'),
        );
      },
    );
  }
}
