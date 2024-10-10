import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/res/components/constants/custom_button.dart';
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
  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
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
              Pinput(
                controller: _otpController,
                length: 6,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: theme.colorScheme.onSurface.withOpacity(.5)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (s) {
                  if (s == null || s.isEmpty) {
                    return "Enter your otp";
                  }
                  return null;
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {
                  authController.verifyOtp(
                    context,
                    widget.verificatoionId,
                    _otpController.text,
                  );
                },
              ),
              Gap(20),
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.verifyOtp(
                      context,
                      widget.verificatoionId,
                      _otpController.text,
                    );
                  }
                },
                btnText: "Verify",
              )
            ],
          ),
        ),
      ),
    );
  }
}
