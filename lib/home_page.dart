import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/product/data/datasources/product_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/usecases/add_product.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/get_all_products.dart';
import 'features/product/domain/usecases/get_categories.dart';
import 'features/product/domain/usecases/get_product.dart';
import 'features/product/domain/usecases/get_products_by_category.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/bloc/product_event.dart';
import 'features/product/presentation/pages/product_list_page.dart';

import 'features/cart/data/datasources/cart_remote_data_source.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/usecases/add_cart.dart';
import 'features/cart/domain/usecases/delete_cart.dart';
import 'features/cart/domain/usecases/get_cart.dart';
import 'features/cart/domain/usecases/get_carts.dart';
import 'features/cart/domain/usecases/get_user_carts.dart';
import 'features/cart/domain/usecases/update_cart.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/cart/presentation/bloc/cart_event.dart';
import 'features/cart/presentation/pages/cart_list_page.dart';

import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/usecases/add_user.dart';
import 'features/user/domain/usecases/delete_user.dart';
import 'features/user/domain/usecases/get_user.dart';
import 'features/user/domain/usecases/get_users.dart';
import 'features/user/domain/usecases/update_user.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/user/presentation/bloc/user_event.dart';

import 'features/auth/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final ProductRepositoryImpl _productRepository;
  late final CartRepositoryImpl _cartRepository;
  late final UserRepositoryImpl _userRepository;

  @override
  void initState() {
    super.initState();
    final client = http.Client();
    _productRepository =
        ProductRepositoryImpl(remoteDataSource: ProductRemoteDataSourceImpl(client));
    _cartRepository =
        CartRepositoryImpl(remoteDataSource: CartRemoteDataSourceImpl(client));
    _userRepository =
        UserRepositoryImpl(remoteDataSource: UserRemoteDataSourceImpl(client));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(
            getAllProducts: GetAllProducts(_productRepository),
            getProduct: GetProduct(_productRepository),
            addProduct: AddProduct(_productRepository),
            updateProduct: UpdateProduct(_productRepository),
            deleteProduct: DeleteProduct(_productRepository),
            getCategories: GetCategories(_productRepository),
            getProductsByCategory: GetProductsByCategory(_productRepository),
          )
            ..add(LoadProducts())
            ..add(LoadCategories()),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(
            getCarts: GetCarts(_cartRepository),
            getCart: GetCart(_cartRepository),
            getUserCarts: GetUserCarts(_cartRepository),
            addCart: AddCart(_cartRepository),
            updateCart: UpdateCart(_cartRepository),
            deleteCart: DeleteCart(_cartRepository),
          )..add(LoadCarts()),
        ),
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(
            getUsers: GetUsers(_userRepository),
            getUser: GetUser(_userRepository),
            addUser: AddUser(_userRepository),
            updateUser: UpdateUser(_userRepository),
            deleteUser: DeleteUser(_userRepository),
          )..add(LoadUsers()),
        ),
      ],
      child: Scaffold(
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const ProductListPage();
      case 1:
        return const CartListPage();
      default:
        return const ProfilePage();
    }
  }
}
