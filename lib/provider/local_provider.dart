import 'package:flutter/material.dart';
import 'package:ftp_connect/service/path_provider.dart';

class LocalProvider extends ChangeNotifier {
  List<String> dir = [];
  List<String> currentFilesDir = [];
  int? selectedDir;
  Future<void> listLocal([String path = '']) async {
    if (path.isEmpty && dir.isEmpty) {
      dir.add('/');
      currentFilesDir = await PathProvider().dir();
    }
    notifyListeners();
  }

  void setSelectedDir(int index) {
    selectedDir = index;
    notifyListeners();
  }

  Future<bool> isFile(String path) async {
    return false;
  }
}
