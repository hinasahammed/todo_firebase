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
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's you sign in",
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(5),
              Text(
                "Welcome back, you have been missed",
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(.5),
                ),
              ),
              const Gap(20),
              CustomTextFormfield(
                controller: _emailController,
                fieldName: "Email",
              ),
              const Gap(10),
              CustomTextFormfield(
                controller: _passwordController,
                fieldName: "Password",
              ),
              const Gap(20),
              TextButton(
                onPressed: () {},
                child: const Text("Forget Password?"),
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
                        authController.login(
                          _emailController.text,
                          _passwordController.text,
                          context,
                        );
                      }
                    },
                    btnText: "Sign in",
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
                    borderRadius: BorderRadius.circular(25),
                  ),
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
                    "Don't have account",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.router.push(RegisterView());
                    },
                    child: const Text("Create one."),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
