import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          leading: Icon(Icons.shopping_bag, size: 24.sp),
          title: Text(product.name, style: TextStyle(fontSize: 16.sp)),
          subtitle: Text(product.details, style: TextStyle(fontSize: 14.sp)),
          trailing: Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
