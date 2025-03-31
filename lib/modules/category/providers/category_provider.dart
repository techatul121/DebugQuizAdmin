import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/states/page_state.dart';
import '../../../services/remote/db/db_exports.dart';
import '../models/category_model.dart';

final categoryProvider =
    AutoDisposeNotifierProvider<_State, PageState<List<CategoryModel>>>(
      _State.new,
    );

class _State extends AutoDisposeNotifier<PageState<List<CategoryModel>>> {
  @override
  PageState<List<CategoryModel>> build() {
    state = PageLoadingState();
    load();
    return state;
  }

  Future<void> load() async {
    final response = await ref
        .read(dbClientProvider.notifier)
        .read(table: DBTablesEnum.quizCategories);

    response.fold(
      (l) {
        state = PageErrorState(l);
      },
      (r) {
        final data = r.map((e) => CategoryModel.fromJson(e)).toList();
        state = PageLoadedState(data);
      },
    );
  }
}
