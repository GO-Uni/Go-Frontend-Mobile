import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_frontend_mobile/services/api_routes.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';

class ChatbotService {
  final DioClient _dioClient;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ChatbotService(this._dioClient);

  Future<String> fetchChatbotMessage(String userMessage) async {
    try {
      final token = await _secureStorage.read(key: 'auth_token');
      final userIdStr = await _secureStorage.read(key: 'user_id');
      final userId = int.tryParse(userIdStr ?? '');

      if (token == null || userId == null) {
        throw Exception("Authentication required.");
      }

      final response = await _dioClient.dio.post(
        ApiRoutes.chatbot(userId),
        data: {"userMessage": userMessage},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 && response.data["status"] == "success") {
        final message = response.data["message"];
        log("✅ Chatbot message: $message");
        return message;
      } else {
        log("❌ Unexpected response: ${response.data}");
        throw Exception("Failed to fetch chatbot message.");
      }
    } catch (e, stackTrace) {
      log("❌ Error fetching chatbot message: $e", stackTrace: stackTrace);
      throw Exception("Error fetching chatbot message.");
    }
  }
}
