import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:go_frontend_mobile/services/api_routes.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';

class ProfileService {
  final DioClient _dioClient;

  ProfileService(this._dioClient);

  Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    try {
      Response response = await _dioClient.dio.put(
        ApiRoutes.updateProfile,
        data: profileData,
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
}
