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

  Future<bool> changeSubscription({
    required String subscriptionType,
    required String paymentMethod,
  }) async {
    try {
      final token = await _secureStorage.read(key: 'auth_token');
      if (token == null) {
        log("❌ No auth token");
        return false;
      }

      final response = await _dioClient.dio.put(
        ApiRoutes.changeSubscription,
        data: {
          "subscription_type": subscriptionType,
          "payment_method": paymentMethod,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      log("✅ Response Status: ${response.statusCode}");
      log("✅ Response Data: ${response.data}");

      return response.statusCode == 200;
    } on DioException catch (e) {
      log("❌ Error: ${e.response}");
      log("❌ Message: ${e.message}");
      return false;
    }
  }

  Future<String?> uploadProfileImage(
    FormData formData, {
    required bool isBusiness,
  }) async {
    try {
      String? token = await _secureStorage.read(key: 'auth_token');
      if (token == null) return null;

      final response = await _dioClient.dio.post(
        isBusiness
            ? ApiRoutes.uploadBusinessMainImage
            : ApiRoutes.uploadProfileImage,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      final data = response.data["data"];
      return isBusiness ? data["main_img"] : data["profile_img"];
    } catch (e) {
      log("❌ Upload profile image failed: $e");
      return null;
    }
  }
}
