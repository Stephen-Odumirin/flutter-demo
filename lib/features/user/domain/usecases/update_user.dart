import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateUser {
  final UserRepository repository;
  UpdateUser(this.repository);

  Future<User> call(int id, Map<String, dynamic> data) async {
    return await repository.updateUser(id, data);
  }
}
