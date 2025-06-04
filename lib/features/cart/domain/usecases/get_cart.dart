import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class GetCart {
  final CartRepository repository;
  GetCart(this.repository);

  Future<Cart> call(int id) async {
    return await repository.getCart(id);
  }
}
