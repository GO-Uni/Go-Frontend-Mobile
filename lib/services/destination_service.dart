import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dio_client.dart';
import 'api_routes.dart';
import 'dart:developer';

class DestinationService {
  final DioClient _dioClient;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  DestinationService(this._dioClient);

  Future<List<Map<String, dynamic>>> fetchDestinationsByCategory(
    String category,
  ) async {
    try {
      Response res = await _dioClient.dio.get(
        ApiRoutes.categoryDestinations(category),
      );

      if (res.data["status"] == "success") {
        return List<Map<String, dynamic>>.from(res.data["data"]);
      } else {
        log("❌ API returned an error: ${res.data}");
        return [];
      }
    } on DioException catch (e) {
      log("❌ Error fetching destinations: ${e.message}");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllDestinations() async {
    try {
      Response res = await _dioClient.dio.get(ApiRoutes.destinations);

      if (res.data["status"] == "success") {
        return List<Map<String, dynamic>>.from(res.data["data"]);
      } else {
        log("❌ API returned an error: ${res.data}");
        return [];
      }
    } on DioException catch (e) {
      log("❌ Error fetching destinations: ${e.message}");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllRecommendedDestinations() async {
    try {
      String? userIdStr = await _secureStorage.read(key: 'user_id');

      if (userIdStr == null) {
        log("❌ User ID not found in secure storage");
        return [];
      }

      int userId = int.parse(userIdStr);

      Response res = await _dioClient.dio.get(
        ApiRoutes.getRecommendedDestination(userId),
      );

      if (res.data["status"] == "success") {
        return List<Map<String, dynamic>>.from(res.data["data"]);
      } else {
        log("❌ API returned an error: ${res.data}");
        return [];
      }
    } on DioException catch (e) {
      log("❌ Error fetching destinations: ${e.message}");
      return [];
    }
  }
}
