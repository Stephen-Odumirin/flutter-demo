import 'package:equatable/equatable.dart';
import '../../domain/entities/cart.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class LoadCarts extends CartEvent {}

class LoadCart extends CartEvent {
  final int id;
  const LoadCart(this.id);

  @override
  List<Object?> get props => [id];
}

class AddCartEvent extends CartEvent {
  final Cart cart;
  const AddCartEvent(this.cart);
}

class UpdateCartEvent extends CartEvent {
  final int id;
  final Map<String, dynamic> data;
  const UpdateCartEvent(this.id, this.data);
}

class DeleteCartEvent extends CartEvent {
  final int id;
  const DeleteCartEvent(this.id);
}
