import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';
import '../services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService(DioClient());

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int? _roleId;
  int? get roleId => _roleId;

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    int? roleId,
    String? businessName,
    String? businessCategory,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _authService.registerUser(
      name: name,
      email: email,
      password: password,
      roleId: roleId ?? 2,
      businessName: businessName,
      businessCategory: businessCategory,
    );

    _isLoading = false;

    if (response['error'] == true) {
      _errorMessage = response['message'];
      notifyListeners();
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _authService.loginUser(
      email: email,
      password: password,
    );

    _isLoading = false;
    log("🔵 Raw Response: $response");

    if (response.containsKey('error') && response['error'] == true) {
      _errorMessage = response['message'] ?? "Invalid response from server";
      notifyListeners();
      return false;
    }

    final data = response['data']?['data'];
    final user = data['user'];
    final token = data['token'];

    if (data == null ||
        !data.containsKey('user') ||
        !data.containsKey('token')) {
      _errorMessage = "Invalid response format from server";
      notifyListeners();
      return false;
    }

    _roleId = user['role_id'];
    log("User Role ID: $_roleId");
    log("Extracted User: $user");
    log("Extracted Token: $token");

    await _secureStorage.write(key: 'auth_token', value: token);
    await _secureStorage.write(key: 'role_id', value: _roleId.toString());

    notifyListeners();
    return true;
  }

  Future<String?> getAuthToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<int?> getRoleId() async {
    String? roleIdStr = await _secureStorage.read(key: 'role_id');
    if (roleIdStr != null) {
      _roleId = int.tryParse(roleIdStr);
      notifyListeners();
      return _roleId;
    }
    return null;
  }

  Future<void> logoutUser() async {
    await _secureStorage.delete(key: 'auth_token');
    await _secureStorage.delete(key: 'role_id');
    notifyListeners();
  }
}
