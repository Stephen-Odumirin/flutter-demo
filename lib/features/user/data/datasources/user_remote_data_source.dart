import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUser(int id);
  Future<UserModel> addUser(UserModel user);
  Future<UserModel> updateUser(int id, Map<String, dynamic> data);
  Future<void> deleteUser(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl(this.client);

  static const baseUrl = 'https://fakestoreapi.com';

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await client.get(Uri.parse('$baseUrl/users'));
    final List<dynamic> data = json.decode(response.body);
    return data.map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  Future<UserModel> getUser(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/users/$id'));
    return UserModel.fromJson(json.decode(response.body));
  }

  @override
  Future<UserModel> addUser(UserModel user) async {
    final response = await client.post(
      Uri.parse('$baseUrl/users'),
      body: json.encode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    return UserModel.fromJson(json.decode(response.body));
  }

  @override
  Future<UserModel> updateUser(int id, Map<String, dynamic> data) async {
    final response = await client.put(
      Uri.parse('$baseUrl/users/$id'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return UserModel.fromJson(json.decode(response.body));
  }

  @override
  Future<void> deleteUser(int id) async {
    await client.delete(Uri.parse('$baseUrl/users/$id'));
  }
}
