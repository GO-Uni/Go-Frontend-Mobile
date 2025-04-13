import 'dart:developer';
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
    log("User data updated in ProfileProvider: ${user.toJson()}");
    notifyListeners();
  }

  Future<bool> updateProfile({
    required Function(UserModel) onUpdate,
    String? name,
    String? businessName,
    int? categoryId,
    String? categoryName,
    String? district,
    String? openingHour,
    String? closingHour,
    int? counterBooking,
    String? businessDescription,
  }) async {
    _isUpdating = true;
    _errorMessage = null;
    notifyListeners();

    Map<String, dynamic> updatedData = {
      if (_user?.roleId == 2 && name != null) "name": name,
      if (_user?.roleId == 3) ...{
        if (businessName != null) "business_name": businessName,
        if (name != null) "name": name,
        if (categoryId != null) "category_id": categoryId,
        if (district != null) "district": district,
        if (openingHour != null) "opening_hour": openingHour,
        if (closingHour != null) "closing_hour": closingHour,
        if (counterBooking != null) "counter_booking": counterBooking,
        if (businessDescription != null) "description": businessDescription,
      },
    };

    try {
      bool success = await _profileService.updateProfile(updatedData);
      if (success) {
        _user = _user?.copyWith(
          name: name ?? _user!.name,
          businessName: businessName ?? _user!.businessName,
          ownerName: name ?? _user!.ownerName,
          businessCategoryId:
              categoryId?.toString() ?? _user!.businessCategoryId,
          businessCategory: categoryName ?? _user!.businessCategory,
          district: district ?? _user!.district,
          openingHour: openingHour ?? _user!.openingHour,
          closingHour: closingHour ?? _user!.closingHour,
          counterBooking: counterBooking ?? _user!.counterBooking,
          businessDescription:
              businessDescription ?? _user!.businessDescription,
        );

        //onUpdate(_user!);

        notifyListeners();

        log("✅ Profile updated successfully!");
        return true;
      } else {
        _errorMessage = "❌ Profile update failed.";
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "❌ Error updating profile: $e";
      log(_errorMessage!);
      notifyListeners();
      return false;
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  Future<bool> loadAuthenticatedUser() async {
    try {
      final userJson = await _profileService.getAuthenticatedUser();

      if (userJson != null) {
        _user = UserModel.fromJson(userJson);
        notifyListeners();
        log("✅ Loaded authenticated user into ProfileProvider.");
        return true;
      } else {
        log("⚠️ No user data found.");
        return false;
      }
    } catch (e) {
      log("❌ Error loading user: $e");
      return false;
    }
  }

  void clearProfile() {
    _user = null;
    notifyListeners();
  }
}
