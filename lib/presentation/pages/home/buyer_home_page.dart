import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flora_match/presentation/blocs/product/product_bloc.dart';
import 'package:flora_match/data/repositories/product_repository.dart';

class BuyerHomePage extends StatelessWidget {
  const BuyerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        productRepository: ProductRepository(),
      )..add(LoadProducts()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Flora Match - Buyer')),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            } else if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return const Center(child: Text('No products found.'));
              }
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text('\$${product.price}'),
                    leading: const Icon(Icons.grass),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}