import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class AddCart {
  final CartRepository repository;
  AddCart(this.repository);

  Future<Cart> call(Cart cart) async {
    return await repository.addCart(cart);
  }
}
