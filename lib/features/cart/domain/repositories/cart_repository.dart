import '../entities/cart.dart';

abstract class CartRepository {
  Future<List<Cart>> getCarts();
  Future<Cart> getCart(int id);
  Future<List<Cart>> getUserCarts(int userId);
  Future<Cart> addCart(Cart cart);
  Future<Cart> updateCart(int id, Map<String, dynamic> data);
  Future<void> deleteCart(int id);
}
