import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiInterceptor = Provider.autoDispose((ref) => ApiInterceptor(ref));

class ApiInterceptor extends Interceptor {
  final Ref ref;

  const ApiInterceptor(this.ref);

  @override
  void onRequest(options, handler) async {
    // final session = LocalStorageServices.session;
    // if (session != null) {
    //   Map<String, String> headers = {
    //     'Authorization': 'Bearer ${session.accessToken}',
    //   };
    //   options.headers.addAll(headers);
    // }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode != null && err.response?.statusCode == 401 ||
        err.response?.statusCode == 403) {
      // ref.read(authProvider.notifier).deAuthenticate();
    }
    handler.next(err);
  }
}
