import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/res/routes/app_router.gr.dart';

class SplashServices {
  final auth = FirebaseAuth.instance;
  Future isLogedin(BuildContext context) async {
    Timer(
      Duration(seconds: 3),
      () {
        auth.authStateChanges().listen(
          (user) {
            if (user == null) {
              if (context.mounted) {
                context.router.replace(LoginView());
              }
            } else {
              if (context.mounted) {
                context.router.replace(HomeView());
              }
            }
          },
        );
      },
    );
  }
}
