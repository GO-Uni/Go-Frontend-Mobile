import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/dio_client.dart';
import '../services/api_routes.dart';

class ActivityService {
  final DioClient _dioClient;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ActivityService(this._dioClient);

  Future<String?> _getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<Map<String, String>> _getHeaders() async {
    String? token = await _getToken();
    if (token == null) {
      log("❌ No auth token found. User is not authenticated.");
      throw Exception("User is not authenticated.");
    }
    return {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
  }

  Future<bool> rateDestination({
    required int businessUserId,
    required double rating,
  }) async {
    try {
      Response response = await _dioClient.dio.post(
        ApiRoutes.rateDestination,
        data: {'business_user_id': businessUserId, 'rating': rating},
        options: Options(headers: await _getHeaders()),
      );

      log("✅ Destination rated successfully: ${response.data}");
      return response.statusCode == 200;
    } catch (e) {
      log("❌ Error rating destination: $e");
      return false;
    }
  }

  Future<bool> saveDestination({required int businessUserId}) async {
    try {
      Response response = await _dioClient.dio.post(
        ApiRoutes.saveDestination,
        data: {'business_user_id': businessUserId},
        options: Options(headers: await _getHeaders()),
      );

      log("✅ Destination saved successfully: ${response.data}");
      return response.statusCode == 200;
    } catch (e) {
      log("❌ Error saving destination: $e");
      return false;
    }
  }

  Future<bool> unsaveDestination({required int businessUserId}) async {
    try {
      Response response = await _dioClient.dio.post(
        ApiRoutes.unsaveDestination,
        data: {'business_user_id': businessUserId},
        options: Options(headers: await _getHeaders()),
      );

      log("✅ Destination unsaved successfully: ${response.data}");
      return response.statusCode == 200;
    } catch (e) {
      log("❌ Error unsaving destination: $e");
      return false;
    }
  }

  Future<bool> reviewDestination({
    required int businessUserId,
    required String review,
  }) async {
    try {
      Response response = await _dioClient.dio.post(
        ApiRoutes.reviewDestination,
        data: {'business_user_id': businessUserId, 'review': review},
        options: Options(headers: await _getHeaders()),
      );

      log("✅ Added Destination review successfully: ${response.data}");
      return response.statusCode == 200;
    } catch (e) {
      log("❌ Error adding review destination: $e");
      return false;
    }
  }
}
