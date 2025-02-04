import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String cartId;
  final String productId;
  final int quantity;

  CartModel({
    required this.cartId,
    required this.productId,
    required this.quantity,
  });

  // JSON'dan nesne oluşturma
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: json['cartId'],
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  // Nesneyi JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
