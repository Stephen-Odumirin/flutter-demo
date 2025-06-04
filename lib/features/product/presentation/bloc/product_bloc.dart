import 'package:bloc/bloc.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/usecases/get_products_by_category.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/update_product.dart';
import '../../../../core/error/exceptions.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  final GetProduct getProduct;
  final AddProduct addProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;
  final GetCategories getCategories;
  final GetProductsByCategory getProductsByCategory;

  ProductBloc({
    required this.getAllProducts,
    required this.getProduct,
    required this.addProduct,
    required this.updateProduct,
    required this.deleteProduct,
    required this.getCategories,
    required this.getProductsByCategory,
  }) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProduct>(_onLoadProduct);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<LoadCategories>(_onLoadCategories);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await getAllProducts();
      emit(ProductsLoaded(products));
    } on ApiException catch (e) {
      emit(ProductError(e.message));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onLoadProduct(LoadProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final product = await getProduct(event.id);
      emit(ProductLoaded(product));
    } on ApiException catch (e) {
      emit(ProductError(e.message));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onAddProduct(AddProductEvent event, Emitter<ProductState> emit) async {
    try {
      await addProduct(event.product);
      add(LoadProducts());
    } on ApiException catch (e) {
      emit(ProductError(e.message));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(UpdateProductEvent event, Emitter<ProductState> emit) async {
    try {
      await updateProduct(event.id, event.data);
      add(LoadProducts());
    } on ApiException catch (e) {
      emit(ProductError(e.message));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<ProductState> emit) async {
    try {
      await deleteProduct(event.id);
      add(LoadProducts());
    } on ApiException catch (e) {
      emit(ProductError(e.message));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onLoadCategories(LoadCategories event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final categories = await getCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onLoadProductsByCategory(LoadProductsByCategory event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await getProductsByCategory(event.category);
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
