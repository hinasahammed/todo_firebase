import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:todo_firebase/res/components/constants/custom_button.dart';
import 'package:todo_firebase/res/components/constants/custom_textformfield.dart';
import 'package:todo_firebase/res/routes/app_router.gr.dart';
import 'package:todo_firebase/viewmodel/controller/auth/auth_controller.dart';

@RoutePage()
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? profileImage;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
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
              const Gap(30),
              Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () async {
                    final newVal = await authController.pickImage();
                    setState(() {
                      profileImage = newVal;
                    });
                  },
                  child: AvatarGlow(
                      glowRadiusFactor: .3,
                      glowCount: 2,
                      startDelay: const Duration(milliseconds: 1000),
                      glowColor: theme.colorScheme.primary,
                      glowShape: BoxShape.circle,
                      curve: Curves.fastOutSlowIn,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: profileImage != null
                                ? FileImage(profileImage!)
                                : NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwdIVSqaMsmZyDbr9mDPk06Nss404fosHjLg&s"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                ),
              ),
              const Gap(40),
              CustomTextFormfield(
                controller: _nameController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return "Enter your full name";
                  }
                  return null;
                },
                fieldName: "Full name",
              ),
              const Gap(10),
              CustomTextFormfield(
                controller: _emailController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return "Enter your email address";
                  }
                  return null;
                },
                fieldName: "Email address",
              ),
              const Gap(10),
              CustomTextFormfield(
                controller: _passwordController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return "Enter your password";
                  }
                  return null;
                },
                fieldName: "Password",
              ),
              const Gap(50),
              Consumer<AuthController>(
                builder: (context, value, child) => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    status: value.status,
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          profileImage != null) {
                        authController.register(
                          _emailController.text,
                          profileImage!,
                          _nameController.text,
                          _passwordController.text,
                          context,
                        );
                      }
                    },
                    btnText: "Sign up",
                  ),
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
                  onPressed: () {
                    authController.signinWithGoogle(context);
                  },
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
                    onPressed: () {
                      context.pushRoute(const LoginView());
                    },
                    child: const Text("Sign in."),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
