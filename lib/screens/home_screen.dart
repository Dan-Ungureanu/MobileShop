import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../widgets/category_carousel.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _bestSelling = [];
  List<Product> _moreToExplore = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final best = await ApiService.fetchPopularProducts(1, 10);
    final more = await ApiService.fetchMoreToExploreProducts(1, 10);
    setState(() {
      _bestSelling = best;
      _moreToExplore = more;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔍 Search bar with camera
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: const Icon(Icons.search),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // 🎠 Category Carousel
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    const CategoryCarousel(), // Asigură-te că are icon + text într-un cerc
                    const SizedBox(height: 24),

                    // 🔥 Best Selling
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Best Selling",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("See all", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 260,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _bestSelling.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: _bestSelling[index]);
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ✨ More to Explore
                    const Text(
                      "More to Explore",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                      children: _moreToExplore
                          .map((product) => ProductCard(product: product))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
