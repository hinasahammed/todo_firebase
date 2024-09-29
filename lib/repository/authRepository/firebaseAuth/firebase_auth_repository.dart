import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/repository/authRepository/auth_repository.dart';
import 'package:todo_firebase/res/utils/utils.dart';
import 'package:todo_firebase/view/home/home_view.dart';
import 'package:todo_firebase/view/login/login_view.dart';

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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ));
            Utils().showFlushToast(
              context,
              "Success",
              "Login successfull",
            );
          }
        },
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        if (context.mounted) {
          return Utils()
              .showFlushToast(context, 'Error', 'email address is not valid');
        }
      }
      if (error.code == 'user-disabled') {
        if (context.mounted) {
          return Utils()
              .showFlushToast(context, 'Error', 'email has been disabled');
        }
      }
      if (error.code == 'user-not-found') {
        if (context.mounted) {
          return Utils().showFlushToast(context, 'Error',
              'there is no user corresponding to the given email');
        }
      }
      if (error.code == 'wrong-password') {
        if (context.mounted) {
          return Utils()
              .showFlushToast(context, 'Error', 'password is invalid');
        }
      }
      if (error.code == 'invalid-credential') {
        if (context.mounted) {
          return Utils().showFlushToast(context, 'Error', 'Invalid credential');
        }
      }
      if (context.mounted) {
        return Utils()
            .showFlushToast(context, 'Error', error.message.toString());
      }
    }
  }

  @override
  Future<void> logout(BuildContext context) async {
    try {
      await auth.signOut().then(
        (value) {
          if (context.mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ));
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Utils().showFlushToast(context, "Error", e.toString());
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
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ));
            Utils().showFlushToast(
              context,
              "Success",
              "Account created sucessfully",
            );
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          if (context.mounted) {
            Utils()
                .showFlushToast(context, "Error", 'email address is not valid');
          }
        case "weak-password":
          if (context.mounted) {
            Utils().showFlushToast(context, "Error", 'Weak password');
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
        case "email-already-in-use":
          if (context.mounted) {
            Utils().showFlushToast(
                context, "Error", 'Already have an account with this email');
          }
        default:
          Utils()
              .showFlushToast(context, "Error", 'An undefined Error happened.');
      }
    }
  }
}
