import 'package:dio/dio.dart';
import 'dart:developer';

class DioClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://16.171.249.2:8000/api",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  DioClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log("📤 Request: ${options.method} ${options.uri}");
          log("📤 Headers: ${options.headers}");
          log("📤 Body: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log("✅ Response: ${response.statusCode}");
          log("✅ Data: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log("❌ Error: ${e.response?.statusCode}");
          log("❌ Message: ${e.response?.data}");
          return handler.next(e);
        },
      ),
    );
  }
}
