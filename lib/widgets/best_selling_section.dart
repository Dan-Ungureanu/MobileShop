import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/product_card.dart';

class BestSellingSection extends StatelessWidget {
  final List<Product> products;

  const BestSellingSection({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Best Selling',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text('See all', style: TextStyle(color: Colors.green)),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          ),
        ),
      ],
    );
  }
}

// Icon map pentru string -> IconData
const Map<String, IconData> iconMap = {
  'devices': Icons.devices,
  'woman': Icons.woman,
  'men': Icons.directions_run,
  'gadgets': Icons.headphones,
  'gaming': Icons.sports_esports,
  // adaugă aici toate valorile posibile din API
};
