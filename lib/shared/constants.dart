import 'package:flutter/material.dart';
import 'package:odaz/data/models.dart';

Map<OrderStatus, Map<String, dynamic>> statusDisplays = {
  OrderStatus.placed: {
    "message": "ORDER PLACED",
    "title": "Order placed",
    "description": "Waiting for the vendor to accept your order",
    "icon": Icons.messenger,
  },
  OrderStatus.accepted: {
    "message": "ORDER ACCEPTED",
    "title": "Order accepted",
    "description":
        "The vendor is preparing your order and a ride will pick it up soon",
    "icon": Icons.check,
  },
  OrderStatus.inProgress: {
    "message": "ORDER PICK UP IN PROGRESS",
    "title": "Order pickup in progress",
    "description": "A rider is on the way to the vendor to pick up your order",
    "icon": Icons.timelapse,
  },
  OrderStatus.toCustomer: {
    "message": "ORDER ON THE WAY TO CUSTOMER",
    "title": "Order on the way",
    "description":
        "A rider has picked up your order and is bringing it your way",
    "icon": Icons.delivery_dining,
  },
  OrderStatus.arrived: {
    "message": "ORDER ARRIVED",
    "title": "Order arrived",
    "description": "Your treats are here, don't keep the rider waiting.",
    "icon": Icons.pin_drop,
  },
  OrderStatus.delivered: {
    "message": "ORDER DELIVERED",
    "title": "Order delivered",
    "description": "Enjoy!",
    "icon": Icons.celebration,
  }
};

List<String> statusDisplayNames = [
  "ORDER PLACED",
  "ORDER ACCEPTED",
  "ORDER PICK UP IN PROGRESS",
  "ORDER ON THE WAY TO CUSTOMER",
  "ORDER ARRIVED",
  "ORDER DELIVERED"
];

List<OrderStatus> allStatuses = [
  OrderStatus.placed,
  OrderStatus.accepted,
  OrderStatus.inProgress,
  OrderStatus.toCustomer,
  OrderStatus.arrived,
  OrderStatus.delivered
];

String dummyImage =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQefTBNpczjicRgdavR6B-E7vnfaAyxeYeeA769dOEEBMrDNvbwwybRhWvy0jY-l8ulQGY&usqp=CAU";

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
