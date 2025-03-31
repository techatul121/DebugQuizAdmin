import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/states/page_state.dart';

import '../../../services/remote/db/db_client_provider.dart';
import '../../../services/remote/db/db_exception.dart';
import '../model/login_request_model.dart';
import '../model/session_model.dart';

class _State extends AutoDisposeNotifier<PageState<SessionModel>> {
  @override
  build() {
    state = PageInitialState();
    return state;
  }

  Future<void> login(LoginRequestModel model) async {
    state = PageLoadingState();
    final response = await ref
        .read(dbClientProvider.notifier)
        .signInUsingPassword(email: model.email, password: model.password);

    response.fold(
      (l) {
        state = PageErrorState(DBException(message: l.message));
      },
      (r) {
        state = PageLoadedState(SessionModel.fromJson(r));
      },
    );
  }
}

final loginProvider =
    AutoDisposeNotifierProvider<_State, PageState<SessionModel>>(_State.new);
