/// Configured [Dio] client with Riverpod provider.
library;

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_constants.dart';

/// Global Dio instance — inject via `ref.watch(dioProvider)`.
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    LogInterceptor(
      requestBody: false,
      responseBody: false,
      logPrint: (obj) {
        // ignore: avoid_print — interceptor logging only in debug
        assert(() {
          // Only log in debug mode
          // ignore: avoid_print
          print(obj);
          return true;
        }());
      },
    ),
  );

  return dio;
});
