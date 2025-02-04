import 'package:flutter/material.dart';

class EventLoadModel with ChangeNotifier {
  final int id;
  final String name;
  final String description;
  final String date;
  final String image;
  final int price;
  final int amount;
  final bool isActive;
  final String createDate;

  EventLoadModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.date,
      required this.image,
      required this.price,
      required this.amount,
      required this.createDate,
      required this.isActive});

  // JSON'dan nesne oluşturma
  factory EventLoadModel.fromJson(Map<String, dynamic> json) {
    return EventLoadModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        date: json['date'],
        image: json['image'],
        price: json['price'],
        amount: json['amount'],
        createDate: json['createDate'],
        isActive: json['isActive']);
  }

  // Nesneyi JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date,
      'image': image,
      'price': price,
      'amount': amount,
      'createDate': createDate,
      'isActive': isActive
    };
  }
}
