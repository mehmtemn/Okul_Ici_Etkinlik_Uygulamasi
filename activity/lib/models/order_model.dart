class OrderModel {
  final String orderId;
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  OrderModel({
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  // fromJson ve toJson metotları eklenebilir, böylece OrderModel nesnesini JSON formatına dönüştürebiliriz.
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}
