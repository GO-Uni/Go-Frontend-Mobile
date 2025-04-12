import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_frontend_mobile/services/api_routes.dart';
import 'dart:developer';
import 'dio_client.dart';

final class BookingService {
  final DioClient _dioClient = DioClient();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<bool> bookActivity({
    required int businessUserId,
    required String bookingDate,
    required String bookingTime,
  }) async {
    try {
      String? token = await _secureStorage.read(key: 'auth_token');

      if (token == null) {
        log("No auth token found. User is not authenticated.");
        return false;
      }
      final response = await _dioClient.dio.post(
        ApiRoutes.bookDestination,
        data: {
          'business_user_id': businessUserId,
          'booking_date': bookingDate,
          'booking_time': bookingTime,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("🎉 Booking successful");
        return true;
      } else {
        log("⚠️ Unexpected response: ${response.statusCode}");
        return false;
      }
    } on DioException catch (e) {
      log("❌ Booking failed: ${e.message}");
      return false;
    }
  }
}
