import 'dart:developer';
import 'package:go_frontend_mobile/services/dio_client.dart';
import 'package:go_frontend_mobile/services/api_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SavedService {
  final DioClient _dioClient;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  SavedService(this._dioClient);

  Future<List<Map<String, dynamic>>> getSavedDestinations() async {
    final userIdStr = await _secureStorage.read(key: 'user_id');
    final userId = int.tryParse(userIdStr ?? '');

    if (userId == null) {
      throw Exception("User ID not found in storage.");
    }

    final response = await _dioClient.dio.get(
      ApiRoutes.getSavedDestination(userId),
    );

    if (response.statusCode == 200 && response.data["status"] == "success") {
      final data = response.data["data"] as List;
      log("✅ Saved Dest fetched: ${response.data}");
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to fetch saved destinations");
    }
  }
}
