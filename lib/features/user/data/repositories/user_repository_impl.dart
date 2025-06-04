import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<User>> getUsers() async {
    return await remoteDataSource.getUsers();
  }

  @override
  Future<User> getUser(int id) async {
    return await remoteDataSource.getUser(id);
  }

  @override
  Future<User> addUser(User user) async {
    return await remoteDataSource.addUser(user as UserModel);
  }

  @override
  Future<User> updateUser(int id, Map<String, dynamic> data) async {
    return await remoteDataSource.updateUser(id, data);
  }

  @override
  Future<void> deleteUser(int id) async {
    await remoteDataSource.deleteUser(id);
  }
}
