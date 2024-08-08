
import 'package:flutter/material.dart';

class ImagePathProvider extends ChangeNotifier{
  String _imagePath = '';

  String get imagePath => _imagePath;

  void setImagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }
}