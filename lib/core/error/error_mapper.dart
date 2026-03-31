/// Maps Dio errors to normalised [AppException] types.
library;

import 'package:dio/dio.dart';
import 'app_exception.dart';

abstract final class ErrorMapper {
  /// Convert a [DioException] into a domain-friendly [AppException].
  static AppException fromDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        TimeoutException(e.message ?? 'Request timed out', e),
      DioExceptionType.connectionError =>
        NetworkException(e.message ?? 'Connection error', e),
      DioExceptionType.badResponse => _fromStatusCode(e),
      DioExceptionType.cancel =>
        const NetworkException('Request was cancelled'),
      _ => UnknownException(e.message ?? 'Unknown network error', e),
    };
  }

  /// Convert any generic exception.
  static AppException fromException(Object e) {
    if (e is DioException) return fromDioException(e);
    if (e is AppException) return e;
    if (e is FormatException) return ParseException(e.message, e);
    return UnknownException(e.toString(), e);
  }

  static AppException _fromStatusCode(DioException e) {
    final statusCode = e.response?.statusCode;
    return switch (statusCode) {
      404 => NotFoundException('Resource not found (404)', e),
      _ when statusCode != null && statusCode >= 500 =>
        NetworkException('Server error ($statusCode)', e),
      _ => UnknownException(
          'HTTP $statusCode: ${e.message ?? 'Unknown error'}',
          e,
        ),
    };
  }
}
