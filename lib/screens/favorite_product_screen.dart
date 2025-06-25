import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/controllers/home_controller.dart';
import 'package:shop/screens/product_detail_screen.dart';
import 'package:shop/widgets/product_card.dart';

class FavouriteProductsScreen extends StatelessWidget {
  FavouriteProductsScreen({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite Products')),
      body: Obx(() {
        final favouriteProducts = controller.favouriteProducts;

        if (favouriteProducts.isEmpty) {
          return const Center(child: Text('No favourite products yet!'));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: favouriteProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final product = favouriteProducts[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetailScreen(product: product));
                },
                child: ProductCard(product: product),
              );
            },
          ),
        );
      }),
    );
  }
}
