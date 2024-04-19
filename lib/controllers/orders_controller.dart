import 'package:get/get.dart';
import 'package:odaz/app/tracking_orders.dart';
import 'package:odaz/data/models.dart';
import 'package:odaz/shared/constants.dart';

class OrdersController extends GetxController {
  RxList<OrderModel> orders = RxList<OrderModel>();
  OrderModel? currentOrder;
  // ----
  RxBool isUpdating = false.obs;
  RxInt currentStatusIdx = 0.obs;
  OrderStatus? currentStatus;
  List<OrderStatus> allStatuses = [
    OrderStatus.placed,
    OrderStatus.accepted,
    OrderStatus.inProgress,
    OrderStatus.toCustomer,
    OrderStatus.arrived,
    OrderStatus.delivered
  ];

  @override
  void onInit() {
    super.onInit();
    orders.value = [...dummyOrders];
  }

  void setUpOrderDetails(OrderModel order) {
    currentOrder = order;
    currentStatusIdx.value =
        allStatuses.indexWhere((e) => e == order.currentStatus);
    currentStatus = allStatuses[currentStatusIdx.value];
    Get.to(() => const TrackingOrdersScreen());
  }

  void updateStatus() {
    if (currentOrder != null) {
      var idx = allStatuses
          .indexWhere((element) => element == currentOrder!.currentStatus);
      if (idx == allStatuses.length - 1) {
        idx = 0;
      } else {
        idx = idx + 1;
      }
      currentStatusIdx.value = idx;
      currentOrder!.currentStatus = allStatuses[idx];
      currentStatus = allStatuses[idx];
    }
  }
}
