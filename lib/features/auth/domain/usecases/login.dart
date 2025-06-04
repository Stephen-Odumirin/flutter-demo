import '../entities/token.dart';
import '../repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;
  Login(this.repository);

  Future<Token> call(String username, String password) async {
    return await repository.login(username, password);
  }
}
