import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProduct(int id);
  Future<List<String>> getCategories();
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<ProductModel> addProduct(ProductModel product);
  Future<ProductModel> updateProduct(int id, Map<String, dynamic> data);
  Future<void> deleteProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl(this.client);

  static const baseUrl = 'https://fakestoreapi.com';

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(Uri.parse('$baseUrl/products'));
    final List<dynamic> data = json.decode(response.body);
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/products/$id'));
    return ProductModel.fromJson(json.decode(response.body));
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await client.get(Uri.parse('$baseUrl/products/categories'));
    return (json.decode(response.body) as List<dynamic>).cast<String>();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final response = await client.get(Uri.parse('$baseUrl/products/category/$category'));
    final List<dynamic> data = json.decode(response.body);
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse('$baseUrl/products'),
      body: json.encode(product.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    return ProductModel.fromJson(json.decode(response.body));
  }

  @override
  Future<ProductModel> updateProduct(int id, Map<String, dynamic> data) async {
    final response = await client.put(
      Uri.parse('$baseUrl/products/$id'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return ProductModel.fromJson(json.decode(response.body));
  }

  @override
  Future<void> deleteProduct(int id) async {
    await client.delete(Uri.parse('$baseUrl/products/$id'));
  }
}
