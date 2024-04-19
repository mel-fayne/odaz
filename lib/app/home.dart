import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odaz/controllers/orders_controller.dart';
import 'package:odaz/widgets/count_card.dart';
import 'package:odaz/widgets/order_card.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersCtrl = Get.find<OrdersController>();
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeaderWidget(context),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Active Orders",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CountWidget(count: ordersCtrl.orders.length)
                  ],
                ),
                const Divider(),
                ListView.builder(
                    key: UniqueKey(),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return OrderCard(
                        order: ordersCtrl.orders[index],
                        showOrderStatus: true,
                        showOrderItems: false,
                      );
                    },
                    itemCount: ordersCtrl.orders.length),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60.0,
              foregroundImage: AssetImage("assets/images/google-logo.png"),
            ),
            Text(
              "Melanie Fayne",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "melaniefayne33@gmail.com",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
