import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';
import 'package:go_frontend_mobile/services/saved_service.dart';

class SavedProvider with ChangeNotifier {
  final SavedService _savedService = SavedService(DioClient());
  List<Map<String, dynamic>> _savedDestinations = [];
  bool _isLoading = false;
  String? _error;

  List<Map<String, dynamic>> get savedDestinations => _savedDestinations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSavedDestinations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _savedService.getSavedDestinations();
      _savedDestinations = data;
    } catch (e) {
      _error = "Failed to load saved destinations.";
    }

    _isLoading = false;
    notifyListeners();
  }
}
