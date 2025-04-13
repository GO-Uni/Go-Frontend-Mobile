import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/chatbot_service.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';

class ChatbotProvider extends ChangeNotifier {
  final ChatbotService _chatbotService = ChatbotService(DioClient());

  String? _message;
  String? get message => _message;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> loadChatbotMessage(String userMessage) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _message = await _chatbotService.fetchChatbotMessage(userMessage);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMessage() {
    _message = null;
    notifyListeners();
  }
}
