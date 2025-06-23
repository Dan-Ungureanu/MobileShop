import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../widgets/search_bar.dart' as custom_widgets;
import '../widgets/category_carousel.dart' as custom_widgets;
import '../widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Category> _categories = [];
  int? _selectedCategoryId;
  List<Product> _products = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchProducts(reset: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !_isLoadingMore && _hasMore) {
      _fetchProducts();
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await ApiService.fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _fetchProducts({bool reset = false}) async {
    if (_isLoading || _isLoadingMore) return;
    if (reset) {
      setState(() {
        _isLoading = true;
        _products = [];
        _currentPage = 1;
        _hasMore = true;
      });
    } else {
      setState(() {
        _isLoadingMore = true;
      });
    }
    try {
      final products = await ApiService.fetchPopularProducts(
        _currentPage,
        10,
        categoryId: _selectedCategoryId,
        search: _searchQuery,
      );
      setState(() {
        if (reset) {
          _products = products;
        } else {
          _products.addAll(products);
        }
        _hasMore = products.length == 10;
        if (_hasMore) _currentPage++;
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
    }
  }

  void _onCategorySelected(Category category) {
    setState(() {
      _selectedCategoryId = category.id;
    });
    _fetchProducts(reset: true);
  }

  void _onSearchChanged(String value) {
    _searchQuery = value;
    _fetchProducts(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Shop'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          custom_widgets.SearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          if (_categories.isNotEmpty)
            custom_widgets.CategoryCarousel(
              categories: _categories,
              selectedCategoryId: _selectedCategoryId,
              onCategorySelected: _onCategorySelected,
            ),
          Expanded(
            child: _isLoading && _products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ProductGrid(
                    products: _products,
                    scrollController: _scrollController,
                    isLoadingMore: _isLoadingMore,
                  ),
          ),
        ],
      ),
    );
  }
}
