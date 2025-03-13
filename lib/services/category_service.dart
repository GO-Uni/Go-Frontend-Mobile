import 'package:dio/dio.dart';
import 'dio_client.dart';
import 'api_routes.dart';
import 'dart:developer';

class CategoryService {
  final DioClient _dioClient;

  CategoryService(this._dioClient);

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      Response response = await _dioClient.dio.get(ApiRoutes.categories);
      List<dynamic> categories = response.data['data'];
      return categories.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      log('Error fetching categories: ${e.message}');
      return [];
    }
  }
}
