import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;
  GetUser(this.repository);

  Future<User> call(int id) async {
    return await repository.getUser(id);
  }
}
