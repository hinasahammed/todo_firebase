import 'package:flutter/material.dart';
import 'package:todo_firebase/repository/authRepository/firebaseAuth/firebase_auth_repository.dart';

class AuthController extends ChangeNotifier {
  final _repository = FirebaseAuthRepository();

  Future register(
    String email,
    String password,
    BuildContext context,
  ) async {
    await _repository.register(
      email,
      password,
      context,
    );
  }

  Future login(
    String email,
    String password,
    BuildContext context,
  ) async {
    await _repository.login(
      email,
      password,
      context,
    );
  }

  Future logout(BuildContext context) async {
    await _repository.logout(context);
  }
}
