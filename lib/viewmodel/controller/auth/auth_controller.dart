import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_firebase/data/response/response.dart';
import 'package:todo_firebase/repository/authRepository/firebaseAuth/firebase_auth_repository.dart';
import 'package:todo_firebase/res/utils/utils.dart';

class AuthController extends ChangeNotifier {
  final _repository = FirebaseAuthRepository();
  final auth = FirebaseAuth.instance;
  Response _status = Response.completed;
  Response get status => _status;

  void changeStatus(Response newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  Future register(
    String email,
    String password,
    BuildContext context,
  ) async {
    changeStatus(Response.loading);
    await _repository.register(
      email,
      password,
      context,
    );
    changeStatus(Response.completed);
  }

  Future login(
    String email,
    String password,
    BuildContext context,
  ) async {
    changeStatus(Response.loading);

    await _repository.login(
      email,
      password,
      context,
    );
    changeStatus(Response.completed);
  }

  Future signinWithGoogle(BuildContext context) async {
    await _repository.loginWithGoogle(context);
  }

  Future logout(BuildContext context) async {
    await _repository.logout(context);
  }

  Future<File> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) {
      Utils().showToast("You have to select image");
      return File('');
    } else {
      return File(picked.path);
    }
  }

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

  Future<void> saveImageUrlToFirestore(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .set({'url': imageUrl});
    } catch (e) {
      print('Error saving URL to Firestore: $e');
    }
  }
}
