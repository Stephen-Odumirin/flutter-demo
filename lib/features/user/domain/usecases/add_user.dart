import '../entities/user.dart';
import '../repositories/user_repository.dart';

class AddUser {
  final UserRepository repository;
  AddUser(this.repository);

  Future<User> call(User user) async {
    return await repository.addUser(user);
  }
}
