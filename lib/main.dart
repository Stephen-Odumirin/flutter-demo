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
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/usecases/add_user.dart';
import 'features/user/domain/usecases/delete_user.dart';
import 'features/user/domain/usecases/get_user.dart';
import 'features/user/domain/usecases/get_users.dart';
import 'features/user/domain/usecases/update_user.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'home_page.dart';

void main() {
  final client = http.Client();
  final productRepository =
      ProductRepositoryImpl(remoteDataSource: ProductRemoteDataSourceImpl(client));
  final userRepository =
      UserRepositoryImpl(remoteDataSource: UserRemoteDataSourceImpl(client));
  final authRepository =
      AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceImpl(client));
  runApp(MyApp(
    productRepository: productRepository,
    userRepository: userRepository,
    authRepository: authRepository,
  ));
}

class MyApp extends StatelessWidget {
  final ProductRepositoryImpl productRepository;
  final UserRepositoryImpl userRepository;
  final AuthRepositoryImpl authRepository;

  const MyApp({
    Key? key,
    required this.productRepository,
    required this.userRepository,
    required this.authRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: productRepository),
        RepositoryProvider.value(value: userRepository),
        RepositoryProvider.value(value: authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ProductBloc(
              getAllProducts: GetAllProducts(productRepository),
              getProduct: GetProduct(productRepository),
              addProduct: AddProduct(productRepository),
              updateProduct: UpdateProduct(productRepository),
              deleteProduct: DeleteProduct(productRepository),
              getCategories: GetCategories(productRepository),
              getProductsByCategory: GetProductsByCategory(productRepository),
            )
              ..add(LoadProducts())
              ..add(LoadCategories()),
          ),
          BlocProvider(
            create: (_) => UserBloc(
              getUsers: GetUsers(userRepository),
              getUser: GetUser(userRepository),
              addUser: AddUser(userRepository),
              updateUser: UpdateUser(userRepository),
              deleteUser: DeleteUser(userRepository),
            ),
          ),
          BlocProvider(
            create: (_) => AuthBloc(loginUsecase: Login(authRepository)),
          ),
        ],
        child: const MaterialApp(
          title: 'FakeStore App',
          home: LoginPage(),
        ),
      ),
    );
  }
}
