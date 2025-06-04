import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class LoadProduct extends ProductEvent {
  final int id;
  const LoadProduct(this.id);

  @override
  List<Object?> get props => [id];
}

class AddProductEvent extends ProductEvent {
  final Product product;
  const AddProductEvent(this.product);
}

class UpdateProductEvent extends ProductEvent {
  final int id;
  final Map<String, dynamic> data;
  const UpdateProductEvent(this.id, this.data);
}

class DeleteProductEvent extends ProductEvent {
  final int id;
  const DeleteProductEvent(this.id);
}

class LoadCategories extends ProductEvent {}

class LoadProductsByCategory extends ProductEvent {
  final String category;
  const LoadProductsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}
