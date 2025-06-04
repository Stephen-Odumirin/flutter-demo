import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class GetUserCarts {
  final CartRepository repository;
  GetUserCarts(this.repository);

  Future<List<Cart>> call(int userId) async {
    return await repository.getUserCarts(userId);
  }
}
