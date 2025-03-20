import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/dio_client.dart';
import '../services/api_routes.dart';

class ActivityService {
  final DioClient _dioClient;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ActivityService(this._dioClient);

  Future<bool> rateDestination({
    required int businessUserId,
    required double rating,
  }) async {
    try {
      String? token = await _secureStorage.read(key: 'auth_token');

      if (token == null) {
        log("No auth token found. User is not authenticated.");
        return false;
      }

      Response response = await _dioClient.dio.post(
        ApiRoutes.rateDestination,
        data: {'business_user_id': businessUserId, 'rating': rating},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("❌ Error rating destination: $e");
      return false;
    }
  }

  Future<bool> saveDestination({required int businessUserId}) async {
    try {
      String? token = await _secureStorage.read(key: 'auth_token');

      if (token == null) {
        log("No auth token found. User is not authenticated.");
        return false;
      }

      Response response = await _dioClient.dio.post(
        ApiRoutes.saveDestination,
        data: {'business_user_id': businessUserId},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      log("✅ Destination saved: ${response.data}");
      return response.statusCode == 200;
    } catch (e) {
      log("❌ Error saving destination: $e");
      return false;
    }
  }
}
