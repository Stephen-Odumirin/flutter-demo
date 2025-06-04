import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import 'cart_page.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carts')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<CartBloc>().add(LoadCarts());
              },
              child: ListView.builder(
                itemCount: state.carts.length,
                itemBuilder: (context, index) {
                  final cart = state.carts[index];
                  return ListTile(
                    title: Text('Cart ${cart.id}'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<CartBloc>(),
                            child: CartPage(cartId: cart.id),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      // Swipe down to refresh the list
    );
  }
}
