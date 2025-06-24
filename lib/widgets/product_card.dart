import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // fix pentru scroll orizontal
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagine produs
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(product.category!.icon),
                      ), // sau NetworkImage
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
                // ),
                const SizedBox(height: 8),

                // Nume produs
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                // Descriere produs
                Text(
                  product.details,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 4),

                // Preț
                Text(
                  '\$${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Icon stea
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black12)],
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.star_border, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
