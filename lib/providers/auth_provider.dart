import 'package:flutter/material.dart';
import '../services/sign_up_service.dart';

class AuthProvider extends ChangeNotifier {
  final SignUpService _signUpService = SignUpService();

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
}
