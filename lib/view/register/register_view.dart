import 'package:auto_route/auto_route.dart';
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
              const Gap(20),
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
                      if (_formKey.currentState!.validate()) {
                        authController.register(
                          _emailController.text,
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
