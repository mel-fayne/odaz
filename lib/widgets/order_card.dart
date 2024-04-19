import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odaz/controllers/orders_controller.dart';
import 'package:odaz/data/models.dart';
import 'package:odaz/shared/constants.dart';
import 'package:odaz/shared/utils.dart';
import 'package:odaz/widgets/count_card.dart';

class OrderCard extends StatefulWidget {
  final bool showOrderStatus;
  final bool showOrderItems;
  const OrderCard(
      {super.key, required this.showOrderStatus, required this.showOrderItems});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  final ordersCtrl = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          widget.showOrderStatus
              ? Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: GetBuilder<OrdersController>(builder: (ordersCtrl) {
                    return _buildOrderStatus(
                        statusDisplays[ordersCtrl.currentStatus]);
                  }),
                )
              : const SizedBox(),
          widget.showOrderItems
              ? ExpansionPanelList(
                  expandedHeaderPadding:
                      const EdgeInsets.symmetric(vertical: 5),
                  children: [
                    ExpansionPanel(
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return _buildOrderTile(ordersCtrl.currentOrder!);
                      },
                      body: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Your Items",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CountWidget(
                                    count: ordersCtrl.currentOrder!.quantity)
                              ],
                            ),
                            Wrap(
                              children: _buildOrderItems(
                                  ordersCtrl.currentOrder!.items),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TOTAL",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text(
                                  'Kes.${ordersCtrl.currentOrder!.totalPrice}',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isExpanded: true,
                    )
                  ],
                )
              : _buildOrderTile(ordersCtrl.currentOrder!),
        ],
      ),
    );
  }

  Widget _buildOrderStatus(dynamic orderStatus) {
    return ListTile(
      leading: Icon(
        orderStatus["icon"],
        color: Theme.of(context).colorScheme.tertiaryContainer,
      ),
      title: Text(
        orderStatus['title']!,
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
        ),
      ),
      subtitle: Text(
        orderStatus['description']!,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onTertiary,
          fontSize: 12,
          decoration: TextDecoration.none,
        ),
      ),
      trailing: ElevatedButton(
        onPressed: () {
          ordersCtrl.setUpOrderDetails(ordersCtrl.currentOrder!);
        },
        child: const Text("Track Order"),
      ),
    );
  }

  Widget _buildOrderTile(OrderModel order) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      leading: CircleAvatar(
        radius: 25.0,
        foregroundImage: AssetImage(ordersCtrl.currentOrder!.items[0].image),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ID: ${order.id}"),
          Text("Date: ${formatDateTime(order.date)}"),
        ],
      ),
      subtitle: const Text("Type: Instant"),
    );
  }

  List<Widget> _buildOrderItems(List<OrderItem> orderItems) {
    List<Widget> tiles = [];
    for (int i = 0; i < orderItems.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          tileColor: Theme.of(context).colorScheme.tertiaryContainer,
          leading: CircleAvatar(
            foregroundImage: AssetImage(orderItems[i].image),
            radius: 25,
          ),
          title: Text(orderItems[i].name),
          trailing: Text('Kes.${orderItems[i].price}'),
        ),
      );
      tiles.add(item);
    }
    return tiles;
  }
}
