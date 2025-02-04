import 'package:flutter/material.dart';

class EventModel with ChangeNotifier {
  final String name;
  final String description;
  final String date;
  final String image;
  final String price;
  final String amount;

  EventModel({
    required this.name,
    required this.description,
    required this.date,
    required this.image,
    required this.price,
    required this.amount,
  });

  // JSON'dan nesne oluşturma
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        name: json['name'],
        description: json['description'],
        date: json['date'],
        image: json['image'],
        price: json['price'],
        amount: json['amount']);
  }

  // Nesneyi JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date,
      'image': image,
      'price': price,
      'amount': amount
    };
  }
}
