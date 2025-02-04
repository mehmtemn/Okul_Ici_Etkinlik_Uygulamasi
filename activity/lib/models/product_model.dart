import 'package:flutter/cupertino.dart';
// ignore: unused_import
import 'package:uuid/uuid.dart';

class ProductModel with ChangeNotifier {
  final String productId;
  final String productTitle;
  final String productPrice;
  final String productDate;
  final String productSaat;
  final String productDescription;
  final String productImage;
  final String productQuantity;

  ProductModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productDate,
    required this.productSaat,
    required this.productDescription,
    required this.productImage,
    required this.productQuantity,
  });

  // JSON'dan nesne oluşturma
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['Id'],
      productTitle: json['Name'],
      productPrice: json['Price'],
      productDate: json['Date'],
      productSaat: json['CreateDate'],
      productDescription: json['Description'],
      productImage: json['Image'],
      productQuantity: json['Amount'],
    );
  }

  // Nesneyi JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'Id': productId,
      'Name': productTitle,
      'Price': productPrice,
      'Date': productDate,
      'CreateDate': productSaat,
      'Description': productDescription,
      'Image': productImage,
      'Amount': productQuantity,
    };
  }
}
