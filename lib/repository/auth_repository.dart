import 'package:flutter/material.dart';

abstract class AuthRepository {
  Future<void> register(String email,String password,BuildContext context);

  Future<void> login();

  Future<void> logout();
}