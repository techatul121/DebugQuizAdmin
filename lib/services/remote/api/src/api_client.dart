import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/utils/either.dart';
import '../api.dart';

final apiClient = Provider.autoDispose((ref) => _ApiClient(ref));

class _ApiClient {
  final Ref _ref;

  _ApiClient(this._ref) {
    _addInterceptor();
  }

  void _addInterceptor() {
    _dio.interceptors.add(_ref.read(apiInterceptor));
    _dio.interceptors.add(ApiLoggingInterceptor());
  }

  static const _duration = Duration(seconds: 10);

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.server,
      receiveTimeout: _duration,
      connectTimeout: _duration,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  ApiResponse get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final r = await _dio.get(path, queryParameters: queryParams);
      return right(r.data);
    } on DioException catch (exception) {
      return left(ApiException.exception(exception: exception));
    }
  }

  ApiResponse post(
    String path, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final r = await _dio.post(path, data: data, queryParameters: queryParams);
      return right(r.data);
    } on DioException catch (exception) {
      return left(ApiException.exception(exception: exception));
    }
  }

  ApiResponse postForm(
    String path, {
    required FormData data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final r = await _dio.post(path, data: data, queryParameters: queryParams);
      return right(r.data);
    } on DioException catch (exception) {
      return left(ApiException.exception(exception: exception));
    }
  }

  ApiResponse put(
    String path, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final r = await _dio.put(path, data: data, queryParameters: queryParams);
      return right(r.data);
    } on DioException catch (exception) {
      return left(ApiException.exception(exception: exception));
    }
  }

  ApiResponse putForm(
    String path, {
    required FormData data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final r = await _dio.put(path, data: data, queryParameters: queryParams);
      return right(r.data);
    } on DioException catch (exception) {
      return left(ApiException.exception(exception: exception));
    }
  }

  ApiResponse patch(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final r = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParams,
      );
      return right(r.data);
    } on DioException catch (exception) {
      return left(ApiException.exception(exception: exception));
    }
  }

  ApiResponse patchForm(
    String path, {
    required FormData? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final r = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParams,
      );
      return right(r.data);
    } on DioException catch (exception) {
      return left(ApiException.exception(exception: exception));
    }
  }

  ApiResponse delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final r = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParams,
      );
      return right(r.data);
    } on DioException catch (exception) {
      return left(ApiException.exception(exception: exception));
    }
  }
}
