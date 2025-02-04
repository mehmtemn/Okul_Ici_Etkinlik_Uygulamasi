import 'package:flutter/material.dart';
import 'package:activity/models/cart_model.dart';

class OrderProvider with ChangeNotifier {
  final List<CartModel> _orders = [];

  List<CartModel> get getOrders => _orders;

  void addOrders(List<CartModel> cartItems) {
    _orders.addAll(cartItems);
    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
