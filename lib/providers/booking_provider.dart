import 'package:flutter/material.dart';
import '../services/booking_service.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService = BookingService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isFetchingBookings = false;
  bool get isFetchingBookings => _isFetchingBookings;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _bookingSuccess = false;
  bool get bookingSuccess => _bookingSuccess;

  List<Map<String, dynamic>> _bookings = [];
  List<Map<String, dynamic>> get bookings => _bookings;

  Future<void> bookActivity({
    required int businessUserId,
    required String bookingDate,
    required String bookingTime,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _bookingSuccess = false;
    notifyListeners();

    final success = await _bookingService.bookActivity(
      businessUserId: businessUserId,
      bookingDate: bookingDate,
      bookingTime: bookingTime,
    );

    _isLoading = false;

    if (success) {
      _bookingSuccess = true;
    } else {
      _errorMessage = "Failed to book activity. Please try again.";
    }

    notifyListeners();
  }

  Future<void> fetchBookingsForBusinessUser(int businessUserId) async {
    _isFetchingBookings = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _bookings = await _bookingService.getBookingsForBusinessUser(
        businessUserId,
      );
    } catch (e) {
      _errorMessage = "Failed to fetch bookings.";
      _bookings = [];
    }

    _isFetchingBookings = false;
    notifyListeners();
  }

  void clearBookings() {
    _bookings = [];
    notifyListeners();
  }

  void resetState() {
    _isLoading = false;
    _errorMessage = null;
    _bookingSuccess = false;
    notifyListeners();
  }
}
