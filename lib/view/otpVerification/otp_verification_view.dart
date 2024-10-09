import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/res/components/constants/custom_button.dart';
import 'package:todo_firebase/res/components/constants/custom_textformfield.dart';
import 'package:todo_firebase/viewmodel/controller/auth/auth_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authController = Provider.of<AuthController>(context, listen: false);
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
            Gap(20),
            CustomButton(
                onPressed: () {
                  authController.verifyOtp(
                    context,
                    widget.verificatoionId,
                    _otpController.text,
                  );
                },
                btnText: "Verify")
          ],
        ),
      ),
    );
  }
}
