import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import 'product_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<String> _categories = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is CategoriesLoaded) {
            setState(() {
              _categories = ['All', ...state.categories];
            });
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoaded) {
              return Column(
                children: [
                  if (_categories.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: _selectedCategory ?? 'All',
                        items: _categories
                            .map((c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(c),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                          if (value == 'All') {
                            context.read<ProductBloc>().add(LoadProducts());
                          } else {
                            context
                                .read<ProductBloc>()
                                .add(LoadProductsByCategory(value));
                          }
                        },
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ListTile(
                          title: Text(product.title),
                          subtitle: Text('\$${product.price}'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProductPage(productId: product.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ProductBloc>().add(LoadProducts()),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
