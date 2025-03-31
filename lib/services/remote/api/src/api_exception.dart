import 'package:dio/dio.dart';

import '../../../../common/constants/app_strings_constants.dart';
import 'api_error_enum.dart';

class ApiException implements Exception {
  final String message;
  final ApiError error;

  ApiException({required this.message, required this.error});

  static ApiException exception({required DioException exception}) {
    if (exception.type == DioExceptionType.badResponse) {
      /// here we are checking if the status code is 4xx.
      if (exception.response!.statusCode.toString().startsWith('4')) {
        return ApiException(
          message:
              exception.response!.data['message'] ??
              AppStrings.somethingWentWrong,
          error: ApiError.userError,
        );
      }
      /// here we are checking if the status code is 5xx.
      else if (exception.response!.statusCode.toString().startsWith('5')) {
        return ApiException(
          message:
              exception.response?.data['message'] ?? AppStrings.serverError,
          error: ApiError.other,
        );
      } else {
        return ApiException(
          message: AppStrings.somethingWentWrong,
          error: ApiError.other,
        );
      }
    } else if (exception.type == DioExceptionType.receiveTimeout) {
      return ApiException(
        message: AppStrings.serverTookLongerToRespond,
        error: ApiError.timeout,
      );
    } else if (exception.type == DioExceptionType.connectionTimeout) {
      return ApiException(
        message: AppStrings.unableToConnectWithServer,
        error: ApiError.timeout,
      );
    } else if (exception.type == DioExceptionType.connectionError) {
      return ApiException(
        message: AppStrings.noInternetConnection,
        error: ApiError.noInternet,
      );
    } else {
      if (exception.error != null) {
        if (exception.error.toString().contains(AppStrings.connectionRefused)) {
          return ApiException(
            message: AppStrings.unableToConnectWithServer,
            error: ApiError.timeout,
          );
        } else if (exception.error.toString().contains(
          AppStrings.connectionFailed,
        )) {
          return ApiException(
            message: AppStrings.noInternetConnection,
            error: ApiError.noInternet,
          );
        }
      }
      return ApiException(
        message: AppStrings.somethingWentWrong,
        error: ApiError.other,
      );
    }
  }
}
