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
            'Stalking Made Socially Acceptable: Tracking Your Trinkets',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Text(
              'Welcome Back',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          PrimaryButton(
            onPressed: () async {
              await authCtrl.googleSignIn();
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
              await authCtrl.githubSignIn();
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
