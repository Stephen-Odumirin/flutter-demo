import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartModel>> getCarts();
  Future<CartModel> getCart(int id);
  Future<List<CartModel>> getUserCarts(int userId);
  Future<CartModel> addCart(CartModel cart);
  Future<CartModel> updateCart(int id, Map<String, dynamic> data);
  Future<void> deleteCart(int id);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final http.Client client;
  CartRemoteDataSourceImpl(this.client);

  static const baseUrl = 'https://fakestoreapi.com';

  @override
  Future<List<CartModel>> getCarts() async {
    final response = await client.get(Uri.parse('$baseUrl/carts'));
    final List<dynamic> data = json.decode(response.body);
    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  @override
  Future<CartModel> getCart(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/carts/$id'));
    return CartModel.fromJson(json.decode(response.body));
  }

  @override
  Future<List<CartModel>> getUserCarts(int userId) async {
    final response = await client.get(Uri.parse('$baseUrl/carts/user/$userId'));
    final List<dynamic> data = json.decode(response.body);
    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  @override
  Future<CartModel> addCart(CartModel cart) async {
    final response = await client.post(
      Uri.parse('$baseUrl/carts'),
      body: json.encode(cart.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    return CartModel.fromJson(json.decode(response.body));
  }

  @override
  Future<CartModel> updateCart(int id, Map<String, dynamic> data) async {
    final response = await client.put(
      Uri.parse('$baseUrl/carts/$id'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return CartModel.fromJson(json.decode(response.body));
  }

  @override
  Future<void> deleteCart(int id) async {
    await client.delete(Uri.parse('$baseUrl/carts/$id'));
  }
}
