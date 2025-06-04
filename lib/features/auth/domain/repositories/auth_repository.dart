import '../entities/token.dart';

abstract class AuthRepository {
  Future<Token> login(String username, String password);
}
