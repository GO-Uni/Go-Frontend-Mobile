import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_frontend_mobile/services/api_routes.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';
import 'package:path/path.dart';

class ImagesService {
  final DioClient _dioClient;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ImagesService(this._dioClient);

  Future<List<Map<String, dynamic>>> fetchImgs() async {
    try {
      final token = await _secureStorage.read(key: 'auth_token');
      final userIdStr = await _secureStorage.read(key: 'user_id');
      final userId = int.tryParse(userIdStr ?? '');

      if (token == null || userId == null) {
        throw Exception("Authentication required.");
      }

      Response res = await _dioClient.dio.get(
        ApiRoutes.getImg(userId),
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (res.statusCode == 200 || res.statusCode == 202) {
        final List<Map<String, dynamic>> images =
            List<Map<String, dynamic>>.from(res.data['images']);

        log("response Imgs: ${res.data['images']}");

        return images.cast<Map<String, dynamic>>();
      } else {
        log("⚠️ Unexpected response: ${res.data}");
        return [];
      }
    } on DioException catch (e) {
      log("❌ Error fetching imgs: ${e.message}");
      return [];
    }
  }

  Future<bool> storeImg(File imageFile) async {
    try {
      final token = await _secureStorage.read(key: 'auth_token');
      final userIdStr = await _secureStorage.read(key: 'user_id');
      final userId = int.tryParse(userIdStr ?? '');

      if (token == null || userId == null) {
        throw Exception("Authentication required.");
      }

      final formData = FormData.fromMap({
        'images': await MultipartFile.fromFile(
          imageFile.path,
          filename: basename(imageFile.path),
        ),
      });

      final response = await _dioClient.dio.post(
        ApiRoutes.storeImg(userId),
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 202) {
        log("✅ Image uploaded successfully: ${response.data}");
        return true;
      } else {
        log("⚠️ Image upload failed: ${response.data}");
        return false;
      }
    } on DioException catch (e) {
      log("❌ Dio error uploading image: ${e.message}");
      return false;
    } catch (e) {
      log("❌ Unexpected error: $e");
      return false;
    }
  }

  Future<bool> deleteImages(List<int> imageIds) async {
    try {
      final token = await _secureStorage.read(key: 'auth_token');
      final userIdStr = await _secureStorage.read(key: 'user_id');
      final userId = int.tryParse(userIdStr ?? '');

      if (token == null || userId == null) {
        throw Exception("Authentication required.");
      }

      final response = await _dioClient.dio.delete(
        ApiRoutes.deleteImg(userId),
        data: {"image_ids": imageIds},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        log("🗑️ Images deleted: ${response.data}");
        return true;
      } else {
        log("⚠️ Image delete failed: ${response.data}");
        return false;
      }
    } on DioException catch (e) {
      log("❌ Dio error deleting images: ${e.message}");
      return false;
    } catch (e) {
      log("❌ Unexpected error: $e");
      return false;
    }
  }
}
