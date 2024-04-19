import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:odaz/app/home.dart';
import 'package:odaz/auth/auth_controller.dart';
import 'package:odaz/auth/login.dart';
import 'package:odaz/controllers/orders_controller.dart';
import 'package:odaz/routes.dart';
import 'package:odaz/theme/themes.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  Get.put(OrdersController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    return GetMaterialApp(
      title: 'Odaz',
      theme: odazLightTheme,
      darkTheme: odazDarkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: authCtrl.isAuthenticated.value
          ? HomeScreen.routeName
          : LoginScreen.routeName,
      getPages: [...odazRoutes],
      home: const HomeScreen(),
    );
  }
}
