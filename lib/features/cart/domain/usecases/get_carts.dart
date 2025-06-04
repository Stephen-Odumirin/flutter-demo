import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class GetCarts {
  final CartRepository repository;
  GetCarts(this.repository);

  Future<List<Cart>> call() async {
    return await repository.getCarts();
  }
}
