import 'package:dio/dio.dart';
import 'dart:developer';
import 'dio_client.dart';

class SignUpService {
  final DioClient _dioClient = DioClient();

  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      log("🔵 Sending signup request...");
      Response response = await _dioClient.dio.post(
        "/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "role_id": 2,
        },
      );

      return {"error": false, "data": response.data};
    } on DioException catch (e) {
      return {
        "error": true,
        "message": e.response?.data['message'] ?? "Something went wrong",
      };
    }
  }
}
