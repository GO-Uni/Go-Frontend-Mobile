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
      if (e.toString().contains("No saved destinations") ||
          e.toString().contains("404")) {
        _savedDestinations = [];
        _error = null;
      } else {
        _error = "Failed to load saved destinations.";
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSavedDestinations() {
    _savedDestinations = [];
    _isLoading = false;
    _error = null;
    notifyListeners();
  }

  bool isSaved(int businessUserId) {
    return _savedDestinations.any((dest) => dest['user_id'] == businessUserId);
  }

  void addSavedDestination(int businessUserId) {
    _savedDestinations.add({'user_id': businessUserId});
    notifyListeners();
  }

  void removeSavedDestination(int businessUserId) {
    _savedDestinations.removeWhere((d) => d['user_id'] == businessUserId);
    notifyListeners();
  }
}
