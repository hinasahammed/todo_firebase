import 'dart:io';

abstract class StorageRepository {
  Future<String?> uploadImageToStorage(File image);
  Future storeUserData(String userName, String email,String imageUrl);
}
