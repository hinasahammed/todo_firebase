import 'dart:io';

abstract class StorageRepository {
  Future<String?> uploadImageToStorage(File image);
  Future storeUserData(File image, String userName, String email,String imageUrl);
}
