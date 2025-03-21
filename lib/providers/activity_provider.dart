import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';
import '../services/activity_service.dart';

class ActivityProvider with ChangeNotifier {
  final ActivityService _activityService = ActivityService(DioClient());

  bool _isLoading = false;
  final Set<int> _savedDestinationIds = {};
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool isSaved(int businessUserId) =>
      _savedDestinationIds.contains(businessUserId);

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

  Future<void> saveDestination(int businessUserId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    bool success = await _activityService.saveDestination(
      businessUserId: businessUserId,
    );

    _isLoading = false;
    if (success) {
      _savedDestinationIds.add(businessUserId);
    } else {
      _errorMessage = "Failed to save destination. Please try again.";
    }
    notifyListeners();
  }

  Future<void> unsaveDestination(int businessUserId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    bool success = await _activityService.unsaveDestination(
      businessUserId: businessUserId,
    );

    _isLoading = false;
    if (success) {
      _savedDestinationIds.remove(businessUserId);
    } else {
      _errorMessage = "Failed to unsave destination. Please try again.";
    }
    notifyListeners();
  }

  Future<void> toggleSaveDestination(int businessUserId) async {
    if (isSaved(businessUserId)) {
      await unsaveDestination(businessUserId);
    } else {
      await saveDestination(businessUserId);
    }
  }

  Future<bool> reviewDestination(int businessUserId, String review) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    bool success = await _activityService.reviewDestination(
      businessUserId: businessUserId,
      review: review,
    );

    _isLoading = false;
    if (!success) {
      _errorMessage = "Failed to add review destination. Please try again.";
    }
    notifyListeners();
    return success;
  }
}
