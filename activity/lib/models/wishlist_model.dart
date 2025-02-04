import 'package:flutter/material.dart';

class WishlistModel with ChangeNotifier {
  final String wishlistId;
  final String productId;

  WishlistModel({
    required this.wishlistId,
    required this.productId,
  });

  // JSON'dan nesne oluşturma
  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      wishlistId: json['wishlistId'],
      productId: json['productId'],
    );
  }

  // Nesneyi JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'wishlistId': wishlistId,
      'productId': productId,
    };
  }
}
