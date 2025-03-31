import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/base_response_model.dart';
import '../../../common/states/page_state.dart';
import '../../../services/remote/api/api.dart';
import '../../../services/remote/db/db_exports.dart';

class _State extends AutoDisposeNotifier<PageState<BaseResponseModel>> {
  @override
  PageState<BaseResponseModel> build() {
    state = PageInitialState();
    return state;
  }

  Future<void> clearCache() async {
    state = PageLoadingState();
    final response = await ref.read(apiClient).get(ApiEndpoints.cleanCache);
    response.fold(
      (l) {
        state = PageErrorState(DBException(message: l.message));
      },
      (r) {
        final response = BaseResponseModel.fromJson(r);
        state = PageLoadedState(response);
      },
    );
  }
}

final clearCacheProvider =
    AutoDisposeNotifierProvider<_State, PageState<BaseResponseModel>>(
      _State.new,
    );
