import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';
import '../../../../core/error/exceptions.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      return await remoteDataSource.getAllProducts();
    } on ApiException {
      rethrow;
    }
  }

  @override
  Future<Product> getProduct(int id) async {
    try {
      return await remoteDataSource.getProduct(id);
    } on ApiException {
      rethrow;
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      return await remoteDataSource.getCategories();
    } on ApiException {
      rethrow;
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      return await remoteDataSource.getProductsByCategory(category);
    } on ApiException {
      rethrow;
    }
  }

  @override
  Future<Product> addProduct(Product product) async {
    try {
      return await remoteDataSource.addProduct(product as ProductModel);
    } on ApiException {
      rethrow;
    }
  }

  @override
  Future<Product> updateProduct(int id, Map<String, dynamic> data) async {
    try {
      return await remoteDataSource.updateProduct(id, data);
    } on ApiException {
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    try {
      return await remoteDataSource.deleteProduct(id);
    } on ApiException {
      rethrow;
    }
  }
}
