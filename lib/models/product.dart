class Product {
  final int id;
  final String name;
  final String details;
  final String size;
  final String colour;
  final double price;
  final int soldCount;
  final ProductCategory? category; // Fă-l opțional dacă poate lipsi

  Product({
    required this.id,
    required this.name,
    required this.details,
    required this.size,
    required this.colour,
    required this.price,
    required this.soldCount,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    print('Creating product from: $json');

    final categoryJson = json['category'];
    ProductCategory? category;
    if (categoryJson != null && categoryJson is Map<String, dynamic>) {
      category = ProductCategory.fromJson(categoryJson);
    }

    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      details: json['details'] ?? '',
      size: json['size'] ?? '',
      colour: json['colour'] ?? '',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
      soldCount: json['sold_count'] ?? 0,
      category: category,
    );
  }
}

class ProductCategory {
  final int id;
  final String name;
  final String icon;

  ProductCategory({required this.id, required this.name, required this.icon});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}
