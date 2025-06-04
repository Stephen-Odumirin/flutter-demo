import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/token_model.dart';

abstract class AuthRemoteDataSource {
  Future<TokenModel> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSourceImpl(this.client);

  static const baseUrl = 'https://fakestoreapi.com';

  @override
  Future<TokenModel> login(String username, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login'),
      body: json.encode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    return TokenModel.fromJson(json.decode(response.body));
  }
}
