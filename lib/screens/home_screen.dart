import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop/screens/favorite_product_screen.dart';
import '../controllers/home_controller.dart';
import '../widgets/category_carousel.dart';
import '../widgets/product_card.dart';
import '../screens/product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Get.to(() => FavouriteProductsScreen());
              },
              icon: (const Icon(Icons.explore)),
            ),
            label: "Explore",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: controller.onSearchChanged,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              padding: EdgeInsets.all(12.w),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                      SliverToBoxAdapter(
                        child: Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                      SliverToBoxAdapter(child: const CategoryCarousel()),
                      SliverToBoxAdapter(child: SizedBox(height: 10.h)),

                      SliverAppBar(
                        backgroundColor: Colors.white,
                        pinned: false,
                        floating: false,
                        snap: false,
                        expandedHeight: 260.h,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0.w,
                                  vertical: 8.h,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Best Sell',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 200.h,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  viewportFraction: 0.8,
                                ),
                                items: controller.bestSelling.map((product) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => ProductDetailScreen(
                                          product: product,
                                        ),
                                      );
                                    },
                                    child: ProductCard(product: product),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                      SliverToBoxAdapter(
                        child: Text(
                          "More to Explore",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final product = controller.filteredProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => ProductDetailScreen(product: product),
                              );
                            },
                            child: ProductCard(product: product),
                          );
                        }, childCount: controller.filteredProducts.length),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
