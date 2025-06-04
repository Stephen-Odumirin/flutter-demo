import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getAllProducts() async {
    return await remoteDataSource.getAllProducts();
  }

  @override
  Future<Product> getProduct(int id) async {
    return await remoteDataSource.getProduct(id);
  }

  @override
  Future<List<String>> getCategories() async {
    return await remoteDataSource.getCategories();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    return await remoteDataSource.getProductsByCategory(category);
  }

  @override
  Future<Product> addProduct(Product product) async {
    return await remoteDataSource.addProduct(product as ProductModel);
  }

  @override
  Future<Product> updateProduct(int id, Map<String, dynamic> data) async {
    return await remoteDataSource.updateProduct(id, data);
  }

  @override
  Future<void> deleteProduct(int id) async {
    return await remoteDataSource.deleteProduct(id);
  }
}
