import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/product/data/datasources/product_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/usecases/add_product.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/get_all_products.dart';
import 'features/product/domain/usecases/get_product.dart';
import 'features/product/domain/usecases/get_categories.dart';
import 'features/product/domain/usecases/get_products_by_category.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/bloc/product_event.dart';
import 'features/product/presentation/pages/product_list_page.dart';

void main() {
  final remoteDataSource = ProductRemoteDataSourceImpl(http.Client());
  final repository = ProductRepositoryImpl(remoteDataSource: remoteDataSource);
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final ProductRepositoryImpl repository;
  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FakeStore App',
      home: RepositoryProvider.value(
        value: repository,
        child: BlocProvider(
          create: (_) => ProductBloc(
            getAllProducts: GetAllProducts(repository),
            getProduct: GetProduct(repository),
            addProduct: AddProduct(repository),
            updateProduct: UpdateProduct(repository),
            deleteProduct: DeleteProduct(repository),
            getCategories: GetCategories(repository),
            getProductsByCategory: GetProductsByCategory(repository),
          )
            ..add(LoadProducts())
            ..add(LoadCategories()),
          child: const ProductListPage(),
        ),
      ),
    );
  }
}
