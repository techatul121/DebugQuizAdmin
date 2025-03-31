import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/utils/either.dart';
import 'db_exports.dart';

final dbClientProvider = NotifierProvider<_DBClient, void>(_DBClient.new);

class _DBClient extends Notifier {
  @override
  build() {
    ref.onDispose(() {
      _dbClient.dispose();
    });
  }

  final _dbClient = SupabaseClient(
    DBCredentialConstants.dbUrl,
    DBCredentialConstants.dbAnonKey,
    authOptions: const AuthClientOptions(authFlowType: AuthFlowType.implicit),
  );

  bool isUserLogin() {
    log('Current user ${_dbClient.auth.currentSession}');
    return _dbClient.auth.currentUser != null;
  }

  DBResponse<Map<String, dynamic>> create({
    required DBTablesEnum table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final res = await _dbClient.from(table.name).insert(data).select();

      return right(res.first);
    } on PostgrestException catch (e) {
      debugPrint('[Exception DBClient] [Create] ${e.message}');
      return left(DBException(message: e.message));
    }
  }

  /// Read
  DBResponse<List<Map<String, dynamic>>> read({
    required DBTablesEnum table,
    List<(String column, dynamic value, bool? exclude)>? filters,
    String orderBy = 'id',
    List<String> select = const ['*'],
    int page = 1,
    int limit = 10,
    bool usePagination = false,
  }) async {
    try {
      PostgrestFilterBuilder postgrestFilter = _dbClient
          .from(table.name)
          .select(select.join(','));

      if (filters != null) {
        for (var filter in filters) {
          postgrestFilter =
              filter.$3 ?? false
                  ? postgrestFilter.neq(filter.$1, filter.$2)
                  : postgrestFilter.eq(filter.$1, filter.$2);
        }
      }

      PostgrestTransformBuilder postgrestTransform = postgrestFilter.order(
        orderBy,
        ascending: false,
      );
      if (usePagination) {
        postgrestTransform = postgrestTransform.range((page - 1), limit);
      }

      final data = await postgrestTransform.count(CountOption.exact);
      debugPrint('[Db read] $data');
      return right(data.data);
    } on PostgrestException catch (e) {
      return left(DBException(message: e.message));
    }
  }

  /// Update
  DBResponse<Map<String, dynamic>> update({
    required DBTablesEnum table,
    required Map<String, dynamic> data,

    required (String column, dynamic value) filter,
  }) async {
    try {
      final res = await _dbClient
          .from(table.name)
          .update(data)
          .eq(filter.$1, filter.$2)
          .select()
          .count(CountOption.exact);

      return right(res.data.first);
    } on PostgrestException catch (e) {
      return left(DBException(message: e.message));
    }
  }

  /// Delete
  DBResponse<Map<String, dynamic>> delete({
    required DBTablesEnum table,
    required (String column, dynamic value) filter,
  }) async {
    try {
      final res = await _dbClient
          .from(table.name)
          .delete()
          .eq(filter.$1, filter.$2)
          .select()
          .count(CountOption.exact);
      return right(res.data.first);
    } on PostgrestException catch (e) {
      return left(DBException(message: e.message));
    }
  }

  /// Read Rpc
  DBResponse<Map<String, dynamic>> readRpc({
    required DBTablesEnum rpcMethod,
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      final res = await _dbClient.rpc(rpcMethod.name, params: queryparams);

      return right(res ?? {});
    } on PostgrestException catch (e) {
      return left(DBException(message: e.message));
    }
  }

  /// Sign in using passwrd
  DBResponse<Map<String, dynamic>> signInUsingPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dbClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return right(response.session!.toJson());
    } on AuthException catch (e) {
      return left(DBException(message: e.message));
    }
  }

  DBResponse<Map<String, dynamic>> refereshToken({
    required String refereshToken,
  }) async {
    try {
      final response = await _dbClient.auth.refreshSession(refereshToken);
      return right(response.session!.toJson());
    } on AuthException catch (e) {
      return left(DBException(message: e.message));
    }
  }
}
