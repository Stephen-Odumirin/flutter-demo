import '../entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<User> getUser(int id);
  Future<User> addUser(User user);
  Future<User> updateUser(int id, Map<String, dynamic> data);
  Future<void> deleteUser(int id);
}
