import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/repository/authRepository/auth_repository.dart';
import 'package:todo_firebase/res/routes/app_router.gr.dart';
import 'package:todo_firebase/res/utils/utils.dart';

class FirebaseAuthRepository implements AuthRepository {
  final auth = FirebaseAuth.instance;
  @override
  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          if (context.mounted) {
            Utils().showToast("Login successfull");
            context.router.replaceNamed("/HomeView");
          }
        },
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        if (context.mounted) {
          Utils().showToast("Invalid email");
        }
      }
      if (error.code == 'user-disabled') {
        if (context.mounted) {
          Utils().showToast("Email has been disabled");
        }
      }
      if (error.code == 'user-not-found') {
        if (context.mounted) {
          Utils()
              .showToast("There is no user corresponding to the given email");
        }
      }
      if (error.code == 'wrong-password') {
        if (context.mounted) {
          Utils().showToast("Password is invalid");
        }
      }
      if (error.code == 'invalid-credential') {
        if (context.mounted) {
          Utils().showToast("Invalid credential");
        }
      }
      if (context.mounted) {
        Utils().showToast(error.toString());
      }
    }
  }

  @override
  Future<void> logout(BuildContext context) async {
    try {
      await auth.signOut().then(
        (value) {
          if (context.mounted) {
            context.router.replace(const LoginView());
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Utils().showToast(e.toString());
      }
    }
  }

  @override
  Future<void> register(
      String email, String password, BuildContext context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          if (context.mounted) {
            Utils().showToast("Account created sucessfully");

            context.router.replace(const LoginView());
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          if (context.mounted) {
            Utils().showToast("Email address is not valid");
          }
        case "weak-password":
          if (context.mounted) {
            Utils().showToast("Weak password");
          }
        case "user-disabled":
          if (context.mounted) {
            Utils().showToast("user-disabled");
          }
        case "user-not-found":
          if (context.mounted) {
            Utils().showToast("user not found");
          }
        case "wrong-password":
          if (context.mounted) {
            Utils().showToast("Wrong password");
          }
        case "email-already-in-use":
          if (context.mounted) {
            Utils().showToast("Already have an account with this email");
          }
        default:
          Utils().showToast("An undefined Error happened.");
      }
    }
  }
}
