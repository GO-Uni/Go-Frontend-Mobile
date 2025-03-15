import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/models/user_model.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';
import 'package:go_frontend_mobile/services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService(DioClient());

  UserModel? _user;
  UserModel? get user => _user;

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> updateProfile({
    String? name,
    String? businessName,
    String? ownerName,
    int? categoryId,
    String? district,
    String? openingHour,
    String? closingHour,
    int? counterBooking,
  }) async {
    _isUpdating = true;
    notifyListeners();

    Map<String, dynamic> updatedData = {
      if (_user?.roleId == 2 && name != null) "name": name,
      if (_user?.roleId == 3) ...{
        if (businessName != null) "business_name": businessName,
        if (categoryId != null) "category_id": categoryId,
        if (district != null) "district": district,
        if (openingHour != null) "opening_hour": openingHour,
        if (closingHour != null) "closing_hour": closingHour,
        if (counterBooking != null) "counter_booking": counterBooking,
      },
    };

    bool success = await _profileService.updateProfile(updatedData);

    if (success) {
      _user = _user?.copyWith(
        name: name,
        businessName: businessName,
        businessCategory: categoryId?.toString(),
        district: district,
        openingTime: openingHour,
        closingTime: closingHour,
        counterBooking: counterBooking,
      );
      notifyListeners();
    } else {
      _errorMessage = "Profile update failed";
    }

    _isUpdating = false;
    notifyListeners();
    return success;
  }
}
