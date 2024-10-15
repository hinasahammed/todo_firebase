import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_firebase/data/response/response.dart';
import 'package:todo_firebase/repository/authRepository/firebase/firebase_auth_repository.dart';
import 'package:todo_firebase/repository/storageRepository/firebase/firebase_storage_repository.dart';
import 'package:todo_firebase/res/utils/utils.dart';

class AuthController extends ChangeNotifier {
  final _authRepository = FirebaseAuthRepository();
  final _storageRepository = FirebaseStorageRepository();
  final auth = FirebaseAuth.instance;
  Response _status = Response.completed;
  Response get status => _status;

  void changeStatus(Response newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  Future register(
    String email,
    File image,
    String userName,
    String password,
    BuildContext context,
  ) async {
    changeStatus(Response.loading);
    await _authRepository
        .register(
          email,
          password,
          context,
        )
        .then(
          (value) => saveUserData(image, userName, email),
        );
    changeStatus(Response.completed);
  }

  Future login(
    String email,
    String password,
    BuildContext context,
  ) async {
    changeStatus(Response.loading);

    await _authRepository.login(
      email,
      password,
      context,
    );

    changeStatus(Response.completed);
  }

  Future signinWithGoogle(BuildContext context) async {
    await _authRepository.loginWithGoogle(context);
    await _storageRepository.storeGoogleUserData();
  }

  Future logout(BuildContext context) async {
    await _authRepository.logout(context);
  }

  Future getOtp(BuildContext context, String phoneNumber) async {
    _authRepository.loginWithPhone(context, phoneNumber);
  }

  Future verifyOtp(
      BuildContext context, String verificationId, String smsCode) async {
    _authRepository.verifyOtp(context, verificationId, smsCode);
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

  Future<void> saveUserData(File image, String userName, String email) async {
    String imageUrl =
        await _storageRepository.uploadImageToStorage(image) ?? '';
    await _storageRepository.storeUserData(userName, email, imageUrl);
  }
}
