import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:activity/models/cart_model.dart';
import 'package:activity/models/message_model.dart';
import 'package:activity/models/order_model.dart';
import 'package:activity/models/product_model.dart';
import 'package:activity/models/wishlist_model.dart';

class ApiService {
  final String baseUrl = "http://localhost:5068";

  // Product
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<ProductModel>.from(
          l.map((model) => ProductModel.fromJson(model)));
    } else {
      throw Exception('Etkinlikler yüklenmedi');
    }
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201) {
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Etkinlikler Oluşturulamadı');
    }
  }

  // Cart
  Future<List<CartModel>> fetchCarts() async {
    final response = await http.get(Uri.parse('$baseUrl/carts'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<CartModel>.from(l.map((model) => CartModel.fromJson(model)));
    } else {
      throw Exception('Sepet Yüklenemedi');
    }
  }

  Future<CartModel> createCart(CartModel cart) async {
    final response = await http.post(
      Uri.parse('$baseUrl/carts'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(cart.toJson()),
    );

    if (response.statusCode == 201) {
      return CartModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Sepet Oluşturulamadı');
    }
  }

  // Message
  Future<List<MessageModel>> fetchMessages() async {
    final response = await http.get(Uri.parse('$baseUrl/messages'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<MessageModel>.from(
          l.map((model) => MessageModel.fromJson(model)));
    } else {
      throw Exception('Mesajlar Yüklenemedi');
    }
  }

  Future<MessageModel> createMessage(MessageModel message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messages'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(message.toJson()),
    );

    if (response.statusCode == 201) {
      return MessageModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Mesaj Oluşturulamadı');
    }
  }

  // Order
  Future<List<OrderModel>> fetchOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/orders'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<OrderModel>.from(
          l.map((model) => OrderModel.fromJson(model)));
    } else {
      throw Exception('Siparişler Yüklenemedi');
    }
  }

  Future<OrderModel> createOrder(OrderModel order) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode == 201) {
      return OrderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Sipariş Oluşturulamadı');
    }
  }

  // Wishlist
  Future<List<WishlistModel>> fetchWishlists() async {
    final response = await http.get(Uri.parse('$baseUrl/wishlists'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<WishlistModel>.from(
          l.map((model) => WishlistModel.fromJson(model)));
    } else {
      throw Exception('İstek Listesi Yüklenemedi');
    }
  }

  Future<WishlistModel> createWishlist(WishlistModel wishlist) async {
    final response = await http.post(
      Uri.parse('$baseUrl/wishlists'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(wishlist.toJson()),
    );

    if (response.statusCode == 201) {
      return WishlistModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('İstek Listesi Oluşturulamadı');
    }
  }
}
