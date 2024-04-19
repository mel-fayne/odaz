import 'package:flutter/material.dart';
import 'package:odaz/data/models.dart';

Map<OrderStatus, Map<String, dynamic>> statusDisplays = {
  OrderStatus.placed: {
    "title": "Order placed",
    "description": "Waiting for the vendor to accept your order",
    "icon": Icons.send,
  },
  OrderStatus.accepted: {
    "title": "Order accepted",
    "description":
        "The vendor is preparing your order and a ride will pick it up soon",
    "icon": Icons.check,
  },
  OrderStatus.inProgress: {
    "title": "Order pickup in progress",
    "description": "A rider is on the way to the vendor to pick up your order",
    "icon": Icons.timelapse,
  },
  OrderStatus.toCustomer: {
    "title": "Order on the way",
    "description":
        "A rider has picked up your order and is bringing it your way",
    "icon": Icons.delivery_dining,
  },
  OrderStatus.arrived: {
    "title": "Order arrived",
    "description": "Your treats are here, don't keep the rider waiting.",
    "icon": Icons.pin_drop,
  },
  OrderStatus.delivered: {
    "title": "Order delivered",
    "description": "Enjoy!",
    "icon": Icons.celebration,
  }
};

List<OrderModel> dummyOrders = [
  OrderModel(
    id: "#45677",
    date: DateTime.now().subtract(const Duration(hours: 1)),
    quantity: 3,
    totalPrice: 1450.0,
    currentStatus: OrderStatus.placed,
    items: [
      OrderItem(
          name: "Peri Peri Rice",
          price: 750.0,
          image: "assets/images/peri-peri-rice.png"),
      OrderItem(name: "Fries", price: 400.0, image: "assets/images/fries.png"),
      OrderItem(
          name: "Fruit Salad",
          price: 300.0,
          image: "assets/images/fruit-salad.png"),
    ],
  ),
];
