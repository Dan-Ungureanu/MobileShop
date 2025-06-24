import 'package:flutter/material.dart';
import '../models/product.dart';

class MoreToExploreSection extends StatelessWidget {
  final List<Product> products;

  const MoreToExploreSection({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: Text(product.name),
          subtitle: Text(product.details),
          trailing: Text('\$${product.price.toStringAsFixed(2)}'),
        );
      },
    );
  }
}
