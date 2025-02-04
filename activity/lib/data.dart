// ignore: depend_on_referenced_packages
import 'package:activity/models/event_load_model.dart';
import 'package:dio/dio.dart';
import 'package:activity/models/cart_model.dart';
import 'package:activity/models/event_model.dart';
import 'package:activity/models/message_model.dart';
import 'package:activity/models/order_model.dart';
import 'package:activity/models/product_model.dart';
import 'package:activity/models/wishlist_model.dart';

class Data {
  Dio dio = Dio();

  final String baseUrl = 'http://localhost:5068';

  // Tüm Ürünler
  Future<List<EventLoadModel>> allProducts() async {
    try {
      Response response = await dio.get('$baseUrl/api/Etkinlik/GetAll');
      List<EventLoadModel> products = (response.data as List)
          .map((json) => EventLoadModel.fromJson(json))
          .toList();
      print(products);
      return products;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Tek Ürün
  Future<ProductModel?> singleProduct(String id) async {
    try {
      Response response = await dio.get('$baseUrl/products/$id');
      return ProductModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Tüm Siparişler
  Future<List<OrderModel>> allOrders() async {
    try {
      Response response = await dio.get(
          'http://192.168.1.101:3000/orders'); //buraya bizim kendi apimizi yazıcaz
      List<OrderModel> orders = (response.data as List)
          .map((json) => OrderModel.fromJson(json))
          .toList();
      return orders;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Tek Sipariş
  Future<OrderModel?> singleOrder(String id) async {
    try {
      Response response = await dio.get(
          'http://192.168.1.101:3000/orders/$id'); //buraya bizim kendi apimizi yazıcaz
      return OrderModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Tüm Etkinlikler (Yeni Oluşacak olan)
  Future<List<EventModel>> allEvents() async {
    try {
      Response response = await dio.get(
          'http://192.168.1.101:3000/events'); //buraya bizim kendi apimizi yazıcaz
      List<EventModel> events = (response.data as List)
          .map((json) => EventModel.fromJson(json))
          .toList();
      return events;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Tek Etkinlik (Yeni Oluşacak olan)
  Future<EventModel?> singleEvent(String id) async {
    try {
      Response response = await dio.get(
          'http://192.168.1.101:3000/events/$id'); //buraya bizim kendi apimizi yazıcaz
      return EventModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Tüm Sepet Elemanları
  Future<List<CartModel>> allCartItems() async {
    try {
      Response response = await dio.get(
          'http://192.168.1.101:3000/cart'); //buraya bizim kendi apimizi yazıcaz
      List<CartModel> cartItems = (response.data as List)
          .map((json) => CartModel.fromJson(json))
          .toList();
      return cartItems;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Tek Sepet Elemanı
  Future<CartModel?> singleCartItem(String id) async {
    try {
      Response response = await dio.get(
          'http://192.168.1.101:3000/cart/$id'); //buraya bizim kendi apimizi yazıcaz
      return CartModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Tüm Favori ELemanları
  Future<List<WishlistModel>> allWishlistItems() async {
    try {
      Response response = await dio.get(
          'http://192.168.1.101:3000/wishlist'); //buraya bizim kendi apimizi yazıcaz
      List<WishlistModel> wishlistItems = (response.data as List)
          .map((json) => WishlistModel.fromJson(json))
          .toList();
      return wishlistItems;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Tek Favori Elemanları
  Future<WishlistModel?> singleWishlistItem(String id) async {
    try {
      Response response = await dio.get(
          'http://192.168.1.101:3000/wishlist/$id'); //buraya bizim kendi apimizi yazıcaz
      return WishlistModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Tüm Mesajlar
  Future<List<MessageModel>> allMessages() async {
    try {
      Response response = await dio.get(
          'http://192.168.1.101:3000/messages'); //buraya bizim kendi apimizi yazıcaz
      List<MessageModel> messages = (response.data as List)
          .map((json) => MessageModel.fromJson(json))
          .toList();
      return messages;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Tek Mesaj
  Future<MessageModel?> singleMessage(String id) async {
    try {
      Response response = await dio.get(
          'http://192.168.1.101:3000/messages/$id'); //buraya bizim kendi apimizi yazıcaz
      return MessageModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Mesaj Gönder
  Future<bool> sendMessage(MessageModel message) async {
    try {
      Response response = await dio.post(
        'http://192.168.1.101:3000/messages', //buraya bizim kendi apimizi yazıcaz
        data: message.toJson(),
      );
      return response.statusCode == 201; // Created
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Etkinlik Oluştur
  Future<bool> createEvent(EventModel event) async {
    try {
      Response response = await dio.post(
        '$baseUrl/api/Etkinlik/Create',
        data: event.toJson(),
      );
      return response.statusCode == 200; // Success
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
