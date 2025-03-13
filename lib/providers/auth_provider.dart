import 'package:flutter/material.dart';
import '../services/sign_up_service.dart';
import '../services/login_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer';

class AuthProvider extends ChangeNotifier {
  final SignUpService _signUpService = SignUpService();
  final LoginService _loginService = LoginService();

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _signUpService.registerUser(
      name: name,
      email: email,
      password: password,
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

    final response = await _loginService.loginUser(
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
    if (data == null ||
        !data.containsKey('user') ||
        !data.containsKey('token')) {
      _errorMessage = "Invalid response format from server";
      notifyListeners();
      return false;
    }

    final user = data['user'];
    final token = data['token'];
    log("Extracted User: $user");
    log("Extracted Token: $token");

    await _secureStorage.write(key: 'auth_token', value: token);

    notifyListeners();
    return true;
  }

  Future<String?> getAuthToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<void> logoutUser() async {
    await _secureStorage.delete(key: 'auth_token');
    notifyListeners();
  }
}
