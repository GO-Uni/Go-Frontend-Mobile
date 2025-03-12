import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://127.0.0.1:8000/api",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  DioClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }
}
