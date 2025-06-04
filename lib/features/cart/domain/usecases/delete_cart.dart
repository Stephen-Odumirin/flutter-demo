import '../repositories/cart_repository.dart';

class DeleteCart {
  final CartRepository repository;
  DeleteCart(this.repository);

  Future<void> call(int id) async {
    await repository.deleteCart(id);
  }
}
