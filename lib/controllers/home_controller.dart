import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop/services/favorites_service.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  var bestSelling = <Product>[].obs;
  var moreToExplore = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var isLoading = true.obs;
  var currentPage = 1;
  final int pageSize = 10;
  var isLoadingMore = false.obs;
  var searchQuery = ''.obs;
  final box = GetStorage();
  var favouriteIds = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
    loadFavourites();
    debounce(
      searchQuery,
      (_) => applyFilter(),
      time: const Duration(milliseconds: 500),
    );
  }

  Future<void> loadInitialData() async {
    isLoading.value = true;
    currentPage = 1;
    final best = await ApiService.fetchPopularProducts(currentPage, pageSize);
    final more = await ApiService.fetchMoreToExploreProducts(
      currentPage,
      pageSize,
    );

    bestSelling.value = best;

    moreToExplore.value = more;

    filteredProducts.value = moreToExplore;

    isLoading.value = false;
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  void applyFilter() {
    if (searchQuery.value.isEmpty) {
      filteredProducts.value = moreToExplore;
    } else {
      filteredProducts.value = moreToExplore.where((product) {
        return product.name.toLowerCase().contains(
          searchQuery.value.toLowerCase(),
        );
      }).toList();
    }
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore.value) return;
    isLoadingMore.value = true;
    currentPage++;
    final more = await ApiService.fetchMoreToExploreProducts(
      currentPage,
      pageSize,
    );
    if (more.isNotEmpty) {
      moreToExplore.addAll(more);
      applyFilter();
    }
    isLoadingMore.value = false;
  }

  Future<void> loadFavourites() async {
    final ids = await FavoritesService().getFavorites();
    favouriteIds.assignAll(ids);
  }

  void toggleFavourite(int productId) async {
    if (favouriteIds.contains(productId)) {
      favouriteIds.remove(productId);
      await FavoritesService().removeFavorite(productId);
    } else {
      favouriteIds.add(productId);
      await FavoritesService().addFavorite(productId);
    }
  }

  bool isFavourite(int productId) {
    return favouriteIds.contains(productId);
  }

  List<Product> get favouriteProducts {
    final allProducts = [...bestSelling, ...moreToExplore];
    return allProducts.where((p) => favouriteIds.contains(p.id)).toList();
  }

  void loadProducts() {
    final storedIds = box.read<List>('favourites')?.cast<int>() ?? [];
    favouriteIds.assignAll(storedIds);
    isLoading.value = false;
  }
}
