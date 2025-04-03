import 'dart:developer';
import 'package:go_frontend_mobile/services/dio_client.dart';
import 'package:go_frontend_mobile/services/api_routes.dart';

class SavedService {
  final DioClient _dioClient;

  SavedService(this._dioClient);

  Future<List<Map<String, dynamic>>> getSavedDestinations(int userId) async {
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
