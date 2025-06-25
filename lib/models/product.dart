class Product {
  final int id;
  final String name;
  final String details;
  final String size;
  final String colour;
  final double price;
  final int soldCount;
  final bool isFavourite;
  final ProductCategory? category;

  Product({
    required this.id,
    required this.name,
    required this.details,
    required this.size,
    required this.colour,
    required this.price,
    required this.soldCount,
    this.isFavourite = false,
    this.category,
  });
  Product copyWith({bool? isFavourite}) {
    return Product(
      id: id,
      name: name,
      details: 'details',
      size: 'size',
      colour: 'colour',
      price: 0,
      soldCount: 0,
      isFavourite: isFavourite ?? this.isFavourite,
      category: ProductCategory(id: 0, name: 'name', icon: 'icon'),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'details': details,
      'size': size,
      'colour': colour,
      'price': price,
      'sold_count': soldCount,
      'category': category?.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon};
  }
}
