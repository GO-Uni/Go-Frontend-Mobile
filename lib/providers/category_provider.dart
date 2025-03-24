import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/category_service.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService(DioClient());

  List<Map<String, dynamic>> _categories = [];
  List<Map<String, dynamic>> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    _categories = await _categoryService.fetchCategories();

    _isLoading = false;
    notifyListeners();
  }
}
