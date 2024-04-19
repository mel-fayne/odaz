import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:odaz/app/home.dart';
import 'package:odaz/auth/login.dart';
import 'package:odaz/data/models.dart';
import 'package:odaz/shared/constants.dart';
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
    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
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
    } catch (e) {
      debugPrint("Error signing in: $e");
    }
    isGoogleLoading.value = false;
  }

  Future<void> githubLogin() async {
    isGithubLoading.value = true;
    // call github auth
    // store profile
    // store token
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(HomeScreen.routeName);
    });
    isGithubLoading.value = false;
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
