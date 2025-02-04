import 'package:flutter/material.dart';
import 'package:activity/models/product_model.dart';

class EventProvider with ChangeNotifier {
  final List<ProductModel> _events = [];

  List<ProductModel> get getEvents {
    return [..._events];
  }

  void addEvent(ProductModel event) {
    _events.add(event);
    notifyListeners(); // Değişikliklerin dinleyicilere bildirilmesi için
  }
}
