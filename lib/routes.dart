import 'package:get/get.dart';
import 'package:odaz/app/home.dart';
import 'package:odaz/app/tracking_orders.dart';
import 'package:odaz/auth/login.dart';

List<GetPage<dynamic>> odazRoutes = [
  GetPage(
    name: LoginScreen.routeName,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: HomeScreen.routeName,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: TrackingOrdersScreen.routeName,
    page: () => const TrackingOrdersScreen(),
  ),
];
