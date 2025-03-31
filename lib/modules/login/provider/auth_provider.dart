import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/local/local_storage_services.dart';

import '../../../services/remote/db/db_client_provider.dart';
import '../model/session_model.dart';
import '../states/auth_states.dart';

final authProvider = NotifierProvider<_State, AuthState>(_State.new);

class _State extends Notifier<AuthState> {
  @override
  AuthState build() {
    state = AuthInitialState();
    _checkSession();
    return state;
  }

  /// For refresh token
  void _refreshToken({required SessionModel session}) async {
    final response = await ref
        .read(dbClientProvider.notifier)
        .refereshToken(refereshToken: session.refreshToken);
    response.fold((l) => null, (r) async {
      final sessionModel = SessionModel.fromJson(r);
      LocalStorageServices.session = sessionModel;
    });
  }

  SessionModel? get _session => LocalStorageServices.session;

  /// Check session
  void _checkSession() async {
    if (_session != null) {
      _refreshToken(session: _session!);
      authenticate(session: _session!);
    } else {
      deAuthenticate();
    }
  }

  void authenticate({required SessionModel session}) async {
    LocalStorageServices.session = session;
    log('Authentication called ${session.accessToken}');
    state = AuthenticatedState(model: session);
  }

  void deAuthenticate() async {
    log('deAuthenticate called');
    LocalStorageServices.session = null;
    state = UnauthenticatedState();
  }
}
