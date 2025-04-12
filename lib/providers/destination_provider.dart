import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';
import 'package:go_frontend_mobile/services/destination_service.dart';

class DestinationProvider extends ChangeNotifier {
  final DestinationService _destinationService = DestinationService(
    DioClient(),
  );

  List<Map<String, dynamic>> _destinations = [];
  List<Map<String, dynamic>> get destinations => _destinations;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _recommendedDestinations = [];
  List<Map<String, dynamic>> get recommendedDestinations =>
      _recommendedDestinations;

  Future<void> fetchDestinationsByCategory(String category) async {
    _isLoading = true;
    notifyListeners();

    try {
      _destinations = await _destinationService.fetchDestinationsByCategory(
        category,
      );
      log("✅ Destinations cat loaded length: ${_destinations.length}");
    } catch (e) {
      _destinations = [];
      log("❌ Error fetching destinations: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAllDestinations() async {
    _isLoading = true;
    notifyListeners();

    try {
      _destinations = await _destinationService.fetchAllDestinations();
      log("✅ Destinations loaded: ${_destinations.length}");
    } catch (e) {
      _destinations = [];
      log("❌ Error fetching destinations: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchRecommendedDestinations() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recommendedDestinations =
          await _destinationService.fetchAllRecommendedDestinations();
      log("✅ Recommended destinations loaded: ${_destinations.length}");
    } catch (e) {
      _recommendedDestinations = [];
      log("❌ Error fetching recommended destinations: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearDestinations() {
    _destinations = [];
    _recommendedDestinations = [];
    notifyListeners();
  }

  Future<void> fetchDestinationsByName(String name) async {
    _isLoading = true;
    notifyListeners();

    try {
      _destinations = await _destinationService.fetchDestinationsByName(name);
      log("✅ Destinations by name loaded: ${_destinations.length}");
    } catch (e) {
      _destinations = [];
      log("❌ Error fetching destinations by name: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
