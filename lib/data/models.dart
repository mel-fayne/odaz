class UserModel {
  String name;
  String email;
  String image;

  UserModel({required this.name, required this.email, required this.image});
}

class OrderModel {
  String id;
  DateTime date;
  int quantity;
  double totalPrice;
  List<OrderItem> items;
  OrderStatus currentStatus;
  bool isSelected = false;

  OrderModel({
    required this.id,
    required this.date,
    required this.quantity,
    required this.totalPrice,
    required this.items,
    required this.currentStatus,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
      items: (json['items'] as List<dynamic>)
          .map((itemJson) => OrderItem.fromJson(itemJson))
          .toList(),
      currentStatus: OrderStatus.values.firstWhere((status) =>
          status.toString() == 'OrderStatus.${json['currentStatus']}'),
    );
  }
}

class OrderItem {
  final String name;
  final double price;
  final String image;

  OrderItem({required this.name, required this.price, required this.image});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}

enum OrderStatus {
  placed,
  accepted,
  inProgress,
  toCustomer,
  arrived,
  delivered
}
