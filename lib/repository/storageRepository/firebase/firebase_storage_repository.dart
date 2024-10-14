import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_firebase/model/user_model.dart';
import 'package:todo_firebase/repository/storageRepository/storage_repository.dart';
import 'package:todo_firebase/res/utils/utils.dart';

final auth = FirebaseAuth.instance;

class FirebaseStorageRepository implements StorageRepository {
  @override
  Future<String?> uploadImageToStorage(File image) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child(auth.currentUser!.uid);
      UploadTask uploadTask = ref.putFile(image);
      await uploadTask;
      return await ref.getDownloadURL();
    } catch (e) {
      Utils().showToast(e.toString());
      return null;
    }
  }

  @override
  Future storeUserData(
    String userName,
    String email,
    String imageUrl,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .set(
            UserModel(
              userName: userName,
              email: email,
              imageUrl: imageUrl,
            ).toMap(),
          );
    } catch (e) {
      Utils().showToast(e.toString());
    }
  }
}
