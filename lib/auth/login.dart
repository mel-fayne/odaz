import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odaz/auth/auth_controller.dart';
import 'package:odaz/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Image.asset(
            'assets/images/odaz-logo.png',
            height: 100,
            scale: 2.5,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Stalking Made Deliciously Acceptable: Track Your Treats.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            child: Text(
              'Welcome Back',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          PrimaryButton(
            onPressed: () async {
              await authCtrl.googleLogin();
            },
            isLoading: authCtrl.isGoogleLoading,
            label: "Continue with Google",
            imagePath: "assets/images/google-logo.png",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "or",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          PrimaryButton(
            onPressed: () async {
              await authCtrl.githubLogin(context);
            },
            isLoading: authCtrl.isGithubLoading,
            label: "Continue with Github",
            imagePath: "assets/images/github-logo.png",
          ),
        ],
      ),
    );
  }
}
