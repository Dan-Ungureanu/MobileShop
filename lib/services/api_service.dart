import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'http://mobile-shop-api.hiring.devebs.net';

  // static Future<List<Category>> fetchCategories() async {
  //   final response = await http.get(Uri.parse('$baseUrl/categories'));
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final List results = data['results'];
  //     return results.map((json) => Category.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load categories');
  //   }
  // }

  static Future<List<Product>> fetchPopularProducts(
    int page,
    int pageSize, {
    int? categoryId,
    String? search,
  }) async {
    var uri = Uri.parse('$baseUrl/products/best-sold-products').replace(
      queryParameters: {
        'page': page.toString(),
        'page_size': pageSize.toString(),
        if (categoryId != null) 'category_id': categoryId.toString(),
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Product>> fetchMoreToExploreProducts(
    int page,
    int pageSize, {
    int? categoryId,
    String? search,
  }) async {
    var uri = Uri.parse('$baseUrl/products').replace(
      queryParameters: {
        'page': page.toString(),
        'page_size': pageSize.toString(),
        if (categoryId != null) 'category_id': categoryId.toString(),
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
