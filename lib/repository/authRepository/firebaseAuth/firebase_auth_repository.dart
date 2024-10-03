import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
            context.router.replaceNamed("/HomeView");
          }
          Utils().showToast("Login successfull");
        },
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        Utils().showToast("Invalid email");
      }
      if (error.code == 'user-disabled') {
        Utils().showToast("Email has been disabled");
      }
      if (error.code == 'user-not-found') {
        Utils().showToast("There is no user corresponding to the given email");
      }
      if (error.code == 'wrong-password') {
        Utils().showToast("Password is invalid");
      }
      if (error.code == 'invalid-credential') {
        Utils().showToast("Invalid credential");
      }
      Utils().showToast(error.toString());
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
      Utils().showToast(e.toString());
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
            context.router.replace(const LoginView());
          }
          Utils().showToast("Account created sucessfully");
        },
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          Utils().showToast("Email address is not valid");

        case "weak-password":
          Utils().showToast("Weak password");

        case "user-disabled":
          Utils().showToast("user-disabled");

        case "user-not-found":
          Utils().showToast("user not found");

        case "wrong-password":
          Utils().showToast("Wrong password");

        case "email-already-in-use":
          Utils().showToast("Already have an account with this email");

        default:
          Utils().showToast("An undefined Error happened.");
      }
    }
  }

  @override
  Future loginWithGoogle(BuildContext context) async {
    try {
      final googleUser = await GoogleSignIn(
              clientId:
                  "699057576920-rih8rbg5cb95gjug839cbgnr4697tv9e.apps.googleusercontent.com")
          .signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      await auth.signInWithCredential(cred).then(
        (value) {
          if (context.mounted) {
            context.router.replaceNamed("/HomeView");
          }
          Utils().showToast("Login successfull");
        },
      );
    } catch (e) {
      Utils().showToast(e.toString());
    }
  }
}
