import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:odaz/app/home.dart';
import 'package:odaz/auth/login.dart';
import 'package:odaz/data/models.dart';
import 'package:odaz/shared/constants.dart';
import 'package:odaz/shared/urls.dart';
import 'package:odaz/shared/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? currentGoogleUser;
  RxBool isGoogleLoading = false.obs;
  RxBool isGithubLoading = false.obs;
  RxBool isAuthenticated = false.obs;
  UserModel currentUser = UserModel(
      name: "Jane Doe", email: "janeDoe@gamil.com", image: dummyImage);

  @override
  void onInit() async {
    super.onInit();
    await checkUserAuth();
  }

  Future<void> checkUserAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      isAuthenticated.value = false;
    } else {
      isAuthenticated.value = true;
      await setUserDetails();
    }
    return;
  }

  Future<void> googleLogin() async {
    isGoogleLoading.value = true;
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    currentGoogleUser = googleUser;
    final googleAuth = await googleUser.authentication;
    OAuthCredential googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await signInGesture(googleCredential);
    } catch (e) {
      debugPrint("Error signing in: $e");
      showSnackbar(
          path: Icons.close_rounded,
          title: "Failed Sign Up!",
          subtitle: "Please check your internet connection or try again later");
    }
    isGoogleLoading.value = false;
  }

  Future<void> githubLogin(BuildContext context) async {
    isGithubLoading.value = true;
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: gitId,
        clientSecret: gitPassKey,
        redirectUrl: gitAuthRedirectUrl);
    final result = await gitHubSignIn.signIn(context);
    final githubAuthCredential =
        GithubAuthProvider.credential(result.token ?? "");

    try {
      await signInGesture(githubAuthCredential);
    } catch (e) {
      debugPrint("Error signing in: $e");
      showSnackbar(
          path: Icons.close_rounded,
          title: "Failed Sign Up!",
          subtitle: "Please check your internet connection or try again later");
    }
    isGithubLoading.value = false;
  }

  Future<void> signInGesture(dynamic credential) async {
    UserCredential fbUser =
        await FirebaseAuth.instance.signInWithCredential(credential);
    await storeGoogleAuth(credential, fbUser.user);
    await setUserDetails();
    showSnackbar(
        path: Icons.check,
        title: "Successful Sign In",
        subtitle: "Welcome to Odaz");
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(HomeScreen.routeName);
  }

  Future<void> storeGoogleAuth(OAuthCredential credential, User? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', credential.accessToken ?? '');
    if (user != null) {
      await prefs.setString('userName', user.displayName ?? '');
      await prefs.setString('userEmail', user.email ?? '');
      await prefs.setString('userImage', user.photoURL ?? '');
      print(user.displayName);
      print(user.email);
      print(user.photoURL);
    }
  }

  Future<void> setUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUser.name = prefs.getString('userName') ?? '';
    currentUser.email = prefs.getString('userEmail') ?? '';
    currentUser.image = prefs.getString('userImage') ?? '';
  }

  Future<void> signOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    showSnackbar(
        path: Icons.logout, title: "Logging out ...", subtitle: "See you soon");
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(LoginScreen.routeName);
  }
}
