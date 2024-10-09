import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_firebase/res/components/constants/custom_button.dart';
import 'package:todo_firebase/res/components/constants/custom_textformfield.dart';
import 'package:todo_firebase/res/routes/app_router.gr.dart';

class OtpVerificationView extends StatefulWidget {
  final String phoneNumber;
  final String verificatoionId;
  const OtpVerificationView(
      {super.key, required this.phoneNumber, required this.verificatoionId});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final auth = FirebaseAuth.instance;
  final _otpController = TextEditingController();

  verifyOtp() async {
    final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificatoionId, smsCode: _otpController.text);

    auth.signInWithCredential(credential);
    context.router.push(CustomNavigationBar());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "OTP verification",
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            Gap(10),
            Text(
              "Enter the Otp sent to ${widget.phoneNumber}",
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            Gap(20),
            CustomTextFormfield(
              controller: _otpController,
              fieldName: "OTP",
            ),
            CustomButton(
                onPressed: () {
                  verifyOtp();
                },
                btnText: "Verify")
          ],
        ),
      ),
    );
  }
}
