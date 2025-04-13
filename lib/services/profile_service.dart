import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_frontend_mobile/services/api_routes.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';

class ProfileService {
  final DioClient _dioClient;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ProfileService(this._dioClient);

  Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    try {
      String? token = await _secureStorage.read(key: 'auth_token');

      if (token == null) {
        log("No auth token found. User is not authenticated.");
        return false;
      }

      log("📤 Sending Profile Update Request: $profileData");

      Response response = await _dioClient.dio.put(
        ApiRoutes.updateProfile,
        data: profileData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        log("Profile updated successfully");
        return true;
      } else {
        log("Failed to update profile: ${response.data}");
        return false;
      }
    } on DioException catch (e) {
      log("Profile update error: ${e.response?.data['message'] ?? e.message}");
      return false;
    }
  }

  Future<Map<String, dynamic>?> getAuthenticatedUser() async {
    try {
      String? token = await _secureStorage.read(key: 'auth_token');

      if (token == null) {
        log("⚠️ No auth token found. Cannot fetch user data.");
        return null;
      }

      final response = await _dioClient.dio.get(
        ApiRoutes.me,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final user = response.data['data']?['user'];
        log("✅ Authenticated user: $user");
        return user;
      } else {
        log("⚠️ Failed to fetch authenticated user: ${response.data}");
        return null;
      }
    } on DioException catch (e) {
      log("❌ Error fetching user: ${e.response?.data['message'] ?? e.message}");
      return null;
    }
  }
}
