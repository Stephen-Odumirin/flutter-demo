import 'package:bloc/bloc.dart';

import '../../domain/usecases/add_cart.dart';
import '../../domain/usecases/delete_cart.dart';
import '../../domain/usecases/get_cart.dart';
import '../../domain/usecases/get_carts.dart';
import '../../domain/usecases/get_user_carts.dart';
import '../../domain/usecases/update_cart.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCarts getCarts;
  final GetCart getCart;
  final GetUserCarts getUserCarts;
  final AddCart addCart;
  final UpdateCart updateCart;
  final DeleteCart deleteCart;

  CartBloc({
    required this.getCarts,
    required this.getCart,
    required this.getUserCarts,
    required this.addCart,
    required this.updateCart,
    required this.deleteCart,
  }) : super(CartInitial()) {
    on<LoadCarts>(_onLoadCarts);
    on<LoadCart>(_onLoadCart);
    on<AddCartEvent>(_onAddCart);
    on<UpdateCartEvent>(_onUpdateCart);
    on<DeleteCartEvent>(_onDeleteCart);
  }

  Future<void> _onLoadCarts(LoadCarts event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final carts = await getCarts();
      emit(CartsLoaded(carts));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cart = await getCart(event.id);
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddCart(AddCartEvent event, Emitter<CartState> emit) async {
    try {
      await addCart(event.cart);
      add(LoadCarts());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onUpdateCart(UpdateCartEvent event, Emitter<CartState> emit) async {
    try {
      await updateCart(event.id, event.data);
      add(LoadCarts());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onDeleteCart(DeleteCartEvent event, Emitter<CartState> emit) async {
    try {
      await deleteCart(event.id);
      add(LoadCarts());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
