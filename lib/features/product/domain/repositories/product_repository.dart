import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<Product> getProduct(int id);
  Future<List<String>> getCategories();
  Future<List<Product>> getProductsByCategory(String category);
  Future<Product> addProduct(Product product);
  Future<Product> updateProduct(int id, Map<String, dynamic> data);
  Future<void> deleteProduct(int id);
}
