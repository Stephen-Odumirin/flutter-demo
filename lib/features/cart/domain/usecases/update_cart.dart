import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class UpdateCart {
  final CartRepository repository;
  UpdateCart(this.repository);

  Future<Cart> call(int id, Map<String, dynamic> data) async {
    return await repository.updateCart(id, data);
  }
}
