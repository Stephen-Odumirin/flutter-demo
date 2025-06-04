import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class ProductPage extends StatelessWidget {
  final int productId;
  const ProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final product = state.product;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, style: Theme.of(context).textTheme.headline6),
                  const SizedBox(height: 8),
                  Text('\$${product.price}', style: Theme.of(context).textTheme.subtitle1),
                  const SizedBox(height: 8),
                  Text(product.description),
                ],
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
