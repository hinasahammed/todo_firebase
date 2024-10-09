import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_firebase/res/components/constants/custom_button.dart';
import 'package:todo_firebase/res/components/constants/custom_textformfield.dart';
import 'package:todo_firebase/res/routes/app_router.gr.dart';
import 'package:todo_firebase/view/otpVerification/otp_verification_view.dart';

@RoutePage()
class PhoneAuthView extends StatefulWidget {
  const PhoneAuthView({super.key});

  @override
  State<PhoneAuthView> createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  final auth = FirebaseAuth.instance;

  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
  }

  phoneAuth() async {
    auth.verifyPhoneNumber(
      phoneNumber: _phoneNumberController.text,
      verificationCompleted: (phoneAuthCredential) {
        auth.signInWithCredential(phoneAuthCredential);
        context.router.push(CustomNavigationBar());
      },
      verificationFailed: (error) {
        print(error);
      },
      codeSent: (verificationId, forceResendingToken) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => OtpVerificationView(
                    phoneNumber: _phoneNumberController.text,
                    verificatoionId: verificationId)));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: Duration(seconds: 60),
    );
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
              "We will send you a One Time Password on this mobile number",
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(.5),
              ),
              textAlign: TextAlign.center,
            ),
            Gap(20),
            CustomTextFormfield(
              controller: _phoneNumberController,
              fieldName: "Enter mobile number",
            ),
            Gap(20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                onPressed: () {
                  phoneAuth();
                },
                btnText: "Get Otp",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
