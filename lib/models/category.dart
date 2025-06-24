class Category {
  final String name;
  final String iconUrl;

  Category({required this.name, required this.iconUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'], iconUrl: json['icon']);
  }
}
