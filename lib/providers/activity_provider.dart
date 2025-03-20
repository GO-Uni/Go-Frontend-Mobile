import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';
import '../services/activity_service.dart';

class ActivityProvider with ChangeNotifier {
  final ActivityService _activityService = ActivityService(DioClient());
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> rateDestination({
    required int businessUserId,
    required double rating,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    bool success = await _activityService.rateDestination(
      businessUserId: businessUserId,
      rating: rating,
    );

    _isLoading = false;
    if (!success) {
      _errorMessage = "Failed to rate destination. Please try again.";
    }
    notifyListeners();

    return success;
  }
}
