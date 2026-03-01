class ProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final double discount;
  final String coverImage;
  final bool homepage;
  final bool active;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.discount,
    required this.coverImage,
    required this.homepage,
    required this.active,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'] ?? "",
      name: data['name'] ?? "",
      category: data['category'] ?? "",
      price: (data['price'] ?? 0).toDouble(),
      discount: (data['discount'] ?? 0).toDouble(),
      coverImage: data['coverImage'] ?? "",
      homepage: data['homepage'] ?? false,
      active: data['active'] ?? true,
    );
  }
}