import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProduct {
  final ProductRepository repository;
  AddProduct(this.repository);

  Future<Product> call(Product product) async {
    return await repository.addProduct(product);
  }
}
