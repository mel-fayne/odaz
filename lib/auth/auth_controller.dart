import 'package:get/get.dart';
import 'package:odaz/app/home.dart';
import 'package:odaz/auth/login.dart';

class AuthController extends GetxController {
  RxBool isGoogleLoading = false.obs;
  RxBool isGithubLoading = false.obs;
  RxBool isAuthenticated = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await checkUserAuth();
  }

  Future<void> checkUserAuth() async {
    // retrieve stored auth
    // check if is valid
    // update isAuthenticated
  }

  Future<void> googleSignIn() async {
    isGoogleLoading.value = true;
    // call google auth
    // store profile
    // store token
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(HomeScreen.routeName);
    });
    isGoogleLoading.value = false;
  }

  Future<void> githubSignIn() async {
    isGithubLoading.value = true;
    // call github auth
    // store profile
    // store token
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(HomeScreen.routeName);
    });
    isGithubLoading.value = false;
  }

  Future<void> signOut() async {
    // clear auth storage
    Get.offAllNamed(LoginScreen.routeName);
  }
}
