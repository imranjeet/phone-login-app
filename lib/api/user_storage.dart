import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class UserStorage {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> uploadProfileImage(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try {
      await _storage.ref('images/$fileName').putFile(file);
      String downloadUrl =
          await _storage.ref('images/$fileName').getDownloadURL();
      return downloadUrl;
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      return "";
    }
  }
}
