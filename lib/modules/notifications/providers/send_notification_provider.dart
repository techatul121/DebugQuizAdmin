import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/base_response_model.dart';

import '../../../common/states/page_state.dart';
import '../../../services/remote/api/api.dart';
import '../../../services/remote/db/db_exception.dart';
import '../models/send_notification_request_model.dart';

class _State extends AutoDisposeNotifier<PageState<BaseResponseModel>> {
  @override
  PageState<BaseResponseModel> build() {
    state = PageInitialState();
    return state;
  }

  Future<void> sendNotification(
    SendNotificationRequestModel model,
    int projectId,
  ) async {
    state = PageLoadingState();
    final response = await ref
        .read(apiClient)
        .post(
          ApiEndpoints.projectNotification(projectId),
          data: model.toJson(),
        );
    response.fold(
      (l) {
        state = PageErrorState(DBException(message: l.message));
      },
      (r) {
        final model = BaseResponseModel.fromJson(r);
        state = PageLoadedState(model);
      },
    );
  }
}

final sendNotificationProvider =
    AutoDisposeNotifierProvider<_State, PageState<BaseResponseModel>>(
      _State.new,
    );
