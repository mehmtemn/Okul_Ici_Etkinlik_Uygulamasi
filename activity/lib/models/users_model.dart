import 'package:flutter/material.dart';

class UsersModel with ChangeNotifier {
  // final int id;
  final String name;
  final String surname;
  final String phone;
  final String password;
  final String email;
  // final bool isActive;
  // final String createDate;

  UsersModel({
    // required this.id,
    required this.name,
    required this.surname,
    required this.phone,
    required this.password,
    required this.email,
    // required this.isActive,
    // required this.createDate
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      // id: json['id'],
      name: json['name'],
      surname: json['surname'],
      phone: json['phone'],
      password: json['password'],
      email: json['email'],
      // isActive: json['isActive'],
      // createDate: json['createDate']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'surname': surname,
      'phone': phone,
      'password': password,
      'email': email,
      // 'isActive': isActive,
      // 'createDate': createDate
    };
  }
}
