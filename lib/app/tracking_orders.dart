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
            const OrderCard(showOrderStatus: false, showOrderItems: true),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.dialog(updateDeliveryDialog());
                    },
                    icon: const Icon(Icons.send),
                    label: const Text("Mock Ably"),
                  ),
                ],
              ),
            ),
            Obx(
              () => Container(
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
                        statusDisplays[ordersCtrl.currentStatus]![
                            "description"],
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
                    ordersCtrl.currentStatusIdx.value == allStatuses.length - 1
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
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: allStatuses
              .map((e) => _buildIndicator(
                    ordersCtrl.currentStatusIdx.value >= e.index,
                    e,
                    e.index == 0,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isComplete, OrderStatus status, bool isFirst) {
    return Row(
      children: [
        !isFirst
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
      ],
    );
  }

  Widget updateDeliveryDialog() {
    return Dialog(
      insetPadding: const EdgeInsets.only(bottom: 90, left: 26, right: 26),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Update Delivery Status",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text("Send a message to Ably to update delivery status",
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                DropdownButton<String>(
                  value: ordersCtrl.statusDropDownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 0,
                  underline: Container(),
                  onChanged: (String? newValue) {
                    ordersCtrl.statusDropDownValue = newValue!;
                    ordersCtrl.sendMessage();
                    setState(() {});
                  },
                  items: statusDisplayNames
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
