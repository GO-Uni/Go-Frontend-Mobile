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

  Future<void> fetchDestinationsByCategory(String category) async {
    _isLoading = true;
    notifyListeners();

    try {
      _destinations = await _destinationService.fetchDestinationsByCategory(
        category,
      );
      log("✅ Destinations loaded: ${_destinations.length}");
    } catch (e) {
      _destinations = [];
      log("❌ Error fetching destinations: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
