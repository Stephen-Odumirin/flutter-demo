import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_data_source.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Cart>> getCarts() async {
    return await remoteDataSource.getCarts();
  }

  @override
  Future<Cart> getCart(int id) async {
    return await remoteDataSource.getCart(id);
  }

  @override
  Future<List<Cart>> getUserCarts(int userId) async {
    return await remoteDataSource.getUserCarts(userId);
  }

  @override
  Future<Cart> addCart(Cart cart) async {
    return await remoteDataSource.addCart(cart as CartModel);
  }

  @override
  Future<Cart> updateCart(int id, Map<String, dynamic> data) async {
    return await remoteDataSource.updateCart(id, data);
  }

  @override
  Future<void> deleteCart(int id) async {
    return await remoteDataSource.deleteCart(id);
  }
}
