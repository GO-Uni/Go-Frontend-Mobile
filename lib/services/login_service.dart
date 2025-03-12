import 'package:dio/dio.dart';
import 'dio_client.dart';

class LoginService {
  final DioClient _dioClient = DioClient();

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _dioClient.dio.post(
        "/login",
        data: {
          "email": email.toLowerCase().trim(),
          "password": password.trim(),
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
