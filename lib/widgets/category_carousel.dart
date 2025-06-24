import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Category {
  final String name;
  final String iconUrl;

  Category({required this.name, required this.iconUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'], iconUrl: json['icon']);
  }
}

class CategoryCarousel extends StatefulWidget {
  const CategoryCarousel({super.key});

  @override
  State<CategoryCarousel> createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends State<CategoryCarousel> {
  List<Category> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response = await http.get(
      Uri.parse('http://mobile-shop-api.hiring.devebs.net/categories'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> results = jsonResponse['results'];

      setState(() {
        categories = results.map((json) => Category.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.network(
                    category.iconUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 80,
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
