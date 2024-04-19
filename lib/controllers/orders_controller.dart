import 'package:ably_flutter/ably_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odaz/app/tracking_orders.dart';
import 'package:odaz/data/models.dart';
import 'package:odaz/shared/constants.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:odaz/shared/urls.dart';

class OrdersController extends GetxController {
  RxList<OrderModel> orders = RxList<OrderModel>();
  OrderModel? currentOrder;
  // ----
  RxBool isUpdating = false.obs;
  RxInt currentStatusIdx = 0.obs;
  OrderStatus? currentStatus;
  // ---
  Realtime? realtime;
  RealtimeChannel? channel;
  String statusDropDownValue = statusDisplays[OrderStatus.placed]!['message'];

  @override
  void onInit() {
    super.onInit();
    orders.value = [...dummyOrders];
    currentOrder = orders[0];
    setUpAblyConnection();
    listenOnAbly();
  }

  void setUpAblyConnection() {
    final clientOptions = ably.ClientOptions(key: ablyKey);
    realtime = ably.Realtime(options: clientOptions);
    realtime!.connection
        .on(ably.ConnectionEvent.connected)
        .listen((ably.ConnectionStateChange stateChange) async {
      debugPrint('New state is: ${stateChange.current}');
      switch (stateChange.current) {
        case ably.ConnectionState.connected:
          debugPrint('Connected');
          break;
        case ably.ConnectionState.failed:
          debugPrint('Failed');
          break;
        case ably.ConnectionState.initialized:
          debugPrint('Initialized');
          break;
        default:
          break;
      }
    });
  }

  void listenOnAbly() {
    channel = realtime!.channels.get('orderStatus');
    channel!.subscribe().listen((message) {
      debugPrint('.');
      debugPrint('..');
      debugPrint('Received a greeting message in realtime: ${message.data}');
      debugPrint('.');
      debugPrint('..');
      updateStatus('${message.data}');
    });
  }

  void setUpOrderDetails(OrderModel order) {
    currentOrder = order;
    currentStatusIdx.value =
        allStatuses.indexWhere((e) => e == order.currentStatus);
    currentStatus = allStatuses[currentStatusIdx.value];
    Get.to(() => const TrackingOrdersScreen());
  }

  Future<void> sendMessage() async {
    final channel = realtime!.channels.get('orderStatus');
    await channel.publish(name: 'greeting', data: statusDropDownValue);
    Get.back();
  }

  void updateStatus(String newStatus) {
    debugPrint("update received");
    debugPrint(newStatus);
    if (currentOrder != null) {
      var idx =
          statusDisplayNames.indexWhere((element) => element == newStatus);
      debugPrint('$idx');
      currentStatusIdx.value = idx;
      currentOrder!.currentStatus = allStatuses[idx];
      currentStatus = allStatuses[idx];
    }
    update();
  }
}
