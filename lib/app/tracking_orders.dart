import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odaz/controllers/orders_controller.dart';
import 'package:odaz/data/models.dart';
import 'package:odaz/shared/constants.dart';
import 'package:odaz/shared/utils.dart';
import 'package:odaz/widgets/order_card.dart';
import 'package:odaz/widgets/primary_button.dart';

class TrackingOrdersScreen extends StatefulWidget {
  static const routeName = "/tracking_orders";

  const TrackingOrdersScreen({super.key});

  @override
  State<TrackingOrdersScreen> createState() => _TrackingOrdersScreenState();
}

class _TrackingOrdersScreenState extends State<TrackingOrdersScreen> {
  final ordersCtrl = Get.find<OrdersController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Order ID: ${ordersCtrl.currentOrder!.id}",
        ),
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            OrderCard(
                order: ordersCtrl.currentOrder!,
                showOrderStatus: false,
                showOrderItems: true),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: PrimaryButton(
                  onPressed: () {
                    ordersCtrl.updateStatus();
                    setState(() {});
                  },
                  label: "Update",
                  isLoading: ordersCtrl.isUpdating),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              child: Column(
                children: [
                  _buildProgressIndicator(),
                  ListTile(
                    textColor: Theme.of(context).colorScheme.tertiary,
                    leading: Icon(
                      statusDisplays[ordersCtrl.currentStatus]!["icon"],
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    title: Text(
                      statusDisplays[ordersCtrl.currentStatus]!["title"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      statusDisplays[ordersCtrl.currentStatus]!["description"],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatTime(DateTime.now()),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onTertiary,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ordersCtrl.currentStatusIdx.value ==
                          ordersCtrl.allStatuses.length - 1
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: PrimaryButton(
                            isLoading: false.obs,
                            onPressed: () {
                              showSnackbar(
                                  path: Icons.stars,
                                  title: "5 Stars!",
                                  subtitle:
                                      "Thank you for your order! Enjoy your meal");
                            },
                            label: "Rate Order",
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return SizedBox(
      width: 320,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: ordersCtrl.allStatuses
            .map((e) => _buildIndicator(
                  ordersCtrl.currentStatusIdx.value >= e.index,
                  e,
                  e.index == ordersCtrl.allStatuses.length - 1,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildIndicator(bool isComplete, OrderStatus status, bool isLast) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
              color: isComplete
                  ? Theme.of(context).colorScheme.tertiaryContainer
                  : Theme.of(context).colorScheme.onTertiary,
              shape: BoxShape.circle),
          child: Center(
            child: Icon(
              statusDisplays[status]!["icon"],
              size: 15,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
        !isLast
            ? Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                  color: isComplete
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : Theme.of(context).colorScheme.onTertiary,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
