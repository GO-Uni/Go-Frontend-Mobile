import 'package:dio/dio.dart';
import 'dart:developer';
import 'dio_client.dart';
import 'api_routes.dart';

class AuthService {
  final DioClient _dioClient;

  AuthService(this._dioClient);

  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
    int? roleId,
    String? businessName,
    int? businessCategory,
    String? subscriptionType,
  }) async {
    try {
      log("🔵 Sending signup request...");

      final Map<String, dynamic> requestData = {
        "name": name,
        "email": email,
        "password": password,
        "role_id": roleId ?? 2,
      };

      if (roleId == 3) {
        requestData.addAll({
          "business_name": businessName,
          "category_id": businessCategory,
          "subscription_type": subscriptionType,
          "payment_method": "pm_card_visa",
        });
      }

      Response response = await _dioClient.dio.post(
        ApiRoutes.register,
        data: requestData,
      );

      return {"error": false, "data": response.data};
    } on DioException catch (e) {
      return {
        "error": true,
        "message": e.response?.data['message'] ?? "Something went wrong",
      };
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _dioClient.dio.post(
        ApiRoutes.login,
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
