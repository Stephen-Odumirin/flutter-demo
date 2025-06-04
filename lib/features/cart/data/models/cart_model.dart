import '../../domain/entities/cart.dart';

class CartModel extends Cart {
  CartModel({
    required int id,
    required int userId,
    required String date,
    required List<dynamic> products,
  }) : super(id: id, userId: userId, date: date, products: products);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: json['products'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date,
      'products': products,
    };
  }
}
