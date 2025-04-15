import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:go_frontend_mobile/services/dio_client.dart';
import 'package:go_frontend_mobile/services/images_service.dart';

class ImgProvider extends ChangeNotifier {
  final ImagesService _imgService = ImagesService(DioClient());

  List<Map<String, dynamic>> _images = [];
  List<Map<String, dynamic>> get images => _images;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchImages(int businessUserId) async {
    _isLoading = true;
    notifyListeners();

    final fetched = await _imgService.fetchImgs(businessUserId);
    _images = fetched;

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> uploadImage(File file, int businessUserId) async {
    _isLoading = true;
    notifyListeners();

    final success = await _imgService.storeImg(file);
    if (success) {
      await fetchImages(businessUserId);
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  Future<bool> deleteImages(List<int> ids) async {
    _isLoading = true;
    notifyListeners();

    final success = await _imgService.deleteImages(ids);
    if (success) {
      _images.removeWhere((img) => ids.contains(img['id']));
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  void clearImages() {
    _images = [];
    _isLoading = false;
    notifyListeners();
  }
}
