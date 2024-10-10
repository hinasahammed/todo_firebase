import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/res/components/constants/custom_button.dart';
import 'package:todo_firebase/res/components/constants/custom_textformfield.dart';
import 'package:todo_firebase/viewmodel/controller/auth/auth_controller.dart';

@RoutePage()
class PhoneAuthView extends StatefulWidget {
  const PhoneAuthView({super.key});

  @override
  State<PhoneAuthView> createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  final auth = FirebaseAuth.instance;

  final _phoneNumberController = TextEditingController();
  String countryCode = '+91';

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
  }

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
              "We will send you a One Time Password on this mobile number",
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(.5),
              ),
              textAlign: TextAlign.center,
            ),
            Gap(20),
            Row(
              children: [
                SizedBox(
                  width: 55,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: theme.colorScheme.onSurface.withOpacity(.5)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CountryCodePicker(
                      alignLeft: true,
                      showFlag: false,
                      padding: EdgeInsets.zero,
                      initialSelection: "+91",
                      onChanged: (value) {
                        setState(() {
                          countryCode = value.code!;
                        });
                      },
                    ),
                  ),
                ),
                Gap(5),
                Expanded(
                  child: CustomTextFormfield(
                    controller: _phoneNumberController,
                    fieldName: "Enter mobile number",
                  ),
                ),
              ],
            ),
            Gap(20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                onPressed: () {
                  authController.getOtp(
                      context, countryCode + _phoneNumberController.text);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => OtpVerificationView(
                  //           phoneNumber: _phoneNumberController.text,
                  //           verificatoionId: ''),
                  //     ));
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
