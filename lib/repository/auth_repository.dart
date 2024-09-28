import 'package:flutter/material.dart';

abstract class AuthRepository {
  Future<void> register(String email,String password,BuildContext context);

  Future<void> login(String email,String password,BuildContext context);

  Future<void> logout();
}