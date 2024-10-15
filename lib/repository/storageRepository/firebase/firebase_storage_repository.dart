import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_firebase/model/user_model.dart';
import 'package:todo_firebase/repository/storageRepository/storage_repository.dart';
import 'package:todo_firebase/res/utils/utils.dart';

class FirebaseStorageRepository implements StorageRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<String?> uploadImageToStorage(File image) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child(_auth.currentUser!.uid);
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
      await _firestore.collection('Users').doc(_auth.currentUser!.uid).set(
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

  @override
  Future storeGoogleUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        log("Working Inside");
        await _firestore.collection("Users").doc(currentUser.uid).set(
              UserModel(
                userName: currentUser.displayName ?? "Unknown",
                email: currentUser.email ?? "No email",
                imageUrl: currentUser.photoURL ?? "No image",
              ).toMap(),
            );
      } else {
        Utils().showToast("User is null");
      }
    } catch (e) {
      Utils().showToast(e.toString());
    }
  }
}
