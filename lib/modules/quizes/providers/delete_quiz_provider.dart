import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/base_response_model.dart';
import '../../../common/states/page_state.dart';
import '../../../services/remote/db/db_exports.dart';

final deleteQuizProvider =
    AutoDisposeNotifierProvider<_State, PageState<BaseResponseModel>>(
      _State.new,
    );

class _State extends AutoDisposeNotifier<PageState<BaseResponseModel>> {
  @override
  PageState<BaseResponseModel> build() {
    return PageInitialState();
  }

  Future<void> deleteQuiz({required int id}) async {
    state = PageLoadingState();
    final response = await ref
        .read(dbClientProvider.notifier)
        .delete(table: DBTablesEnum.quizzes, filter: ('id', id));
    response.fold(
      (l) {
        state = PageErrorState(l);
      },
      (r) {
        state = PageLoadedState(
          BaseResponseModel(status: true, message: 'Deleted successfully'),
        );
      },
    );
  }
}
