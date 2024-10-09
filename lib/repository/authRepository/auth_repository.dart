import 'package:flutter/material.dart';

abstract class AuthRepository {
  Future<void> register(String email,String password,BuildContext context);

  Future<void> login(String email,String password,BuildContext context);

  Future<void> logout(BuildContext context);

  Future loginWithGoogle(BuildContext context);

  Future loginWithPhone(BuildContext context,String phoneNumber);

  Future verifyOtp(BuildContext context,String verificationId,String smsCode);
}