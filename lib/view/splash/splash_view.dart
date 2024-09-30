import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_firebase/gen/assets.gen.dart';
import 'package:todo_firebase/viewmodel/services/splash_services.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    SplashServices().isLogedin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Assets.icons.checklyLogo.image(),
          ),
          const Gap(50),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
