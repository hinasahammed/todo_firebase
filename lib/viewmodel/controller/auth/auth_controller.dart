import 'package:flutter/material.dart';
import 'package:todo_firebase/data/response/response.dart';
import 'package:todo_firebase/repository/authRepository/firebaseAuth/firebase_auth_repository.dart';

class AuthController extends ChangeNotifier {
  final _repository = FirebaseAuthRepository();
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
}
