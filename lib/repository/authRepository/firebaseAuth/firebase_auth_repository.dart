import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/repository/auth_repository.dart';
import 'package:todo_firebase/res/utils/utils.dart';

class FirebaseAuthRepository implements AuthRepository {
  final auth = FirebaseAuth.instance;
  @override
  Future<void> login() {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> register(
      String email, String password, BuildContext context) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          if (context.mounted) {
            Utils()
                .showFlushToast(context, "Error", 'email address is not valid');
          }
        case "user-disabled":
          if (context.mounted) {
            Utils().showFlushToast(context, "Error", 'user-disabled');
          }
        case "user-not-found":
          if (context.mounted) {
            Utils().showFlushToast(context, "Error", 'user not found');
          }
        case "wrong-password":
          if (context.mounted) {
            Utils().showFlushToast(context, "Error", 'Wrong password');
          }
        default:
          Utils()
              .showFlushToast(context, "Error", 'An undefined Error happened.');
      }
    }
  }
}
