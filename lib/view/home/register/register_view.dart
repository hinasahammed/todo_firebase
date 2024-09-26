import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:todo_firebase/res/components/common/custom_button.dart';
import 'package:todo_firebase/res/components/common/custom_textformfield.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Checkly.",
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(5),
            Text(
              "And enjoy life during the time you",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(.5),
              ),
            ),
            const Gap(20),
            CustomTextFormfield(
              controller: TextEditingController(),
              fieldName: "Full name",
            ),
            const Gap(10),
            CustomTextFormfield(
              controller: TextEditingController(),
              fieldName: "Email address",
            ),
            const Gap(10),
            CustomTextFormfield(
              controller: TextEditingController(),
              fieldName: "Password",
            ),
            const Gap(50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                onPressed: () {},
                btnText: "Sign up",
              ),
            ),
            const Gap(10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: SignInButton(
                Buttons.google,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () {},
              ),
            ),
            const Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have account",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Sign in."),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
