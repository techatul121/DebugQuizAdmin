import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/states/page_state.dart';
import '../../../services/remote/db/db_exports.dart';

import '../models/quiz_model.dart';

final quizProvider =
    AutoDisposeNotifierProvider<_State, PageState<List<QuizModel>>>(_State.new);

class _State extends AutoDisposeNotifier<PageState<List<QuizModel>>> {
  @override
  PageState<List<QuizModel>> build() {
    state = PageLoadingState();
    load();
    return state;
  }

  Future<void> load() async {
    final response = await ref
        .read(dbClientProvider.notifier)
        .readRpc(rpcMethod: DBRpcEnum.quizCategories);

    response.fold(
      (l) {
        state = PageErrorState(l);
      },
      (r) {
        if (r.isNotEmpty) {
          final data = r.map((e) => QuizModel.fromJson(e)).toList();
          state = PageLoadedState(data);
        } else {
          state = PageErrorState(DBException(message: 'No Data Found'));
        }
      },
    );
  }
}
