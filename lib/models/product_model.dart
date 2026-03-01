class ProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final double discount;
  final String description;
  final String coverImage;
  final bool homepage;
  final bool active;
  final Map<String,int> sizes;

  final Map<String, List<String>> images;
  final List<Map<String, dynamic>> colors;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.discount,
    required this.description,
    required this.coverImage,
    required this.homepage,
    required this.active,
    required this.images,
    required this.colors,
    required this.sizes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) {


    Map<String, int> sizeMap = {};

    if (data['sizes'] != null && data['sizes'] is Map) {
      (data['sizes'] as Map).forEach((key, value) {
        sizeMap[key] = value;
      });
    }

    // SAFE IMAGE MAP
    Map<String, List<String>> imageMap = {};

    if (data['images'] != null &&
        data['images'] is Map) {

      (data['images'] as Map).forEach((key, value) {
        if (value is List) {
          imageMap[key] = List<String>.from(value);
        }
      });
    }

    // SAFE COLOR LIST
    List<Map<String, dynamic>> colorList = [];

    if (data['colors'] != null &&
        data['colors'] is List) {

      for (var item in data['colors']) {
        if (item is Map) {
          colorList.add(
              Map<String, dynamic>.from(item));
        }
      }
    }

    return ProductModel(
      id: data['id'] ?? "",
      name: data['name'] ?? "",
      category: data['category'] ?? "",
      price: (data['price'] ?? 0).toDouble(),
      discount: (data['discount'] ?? 0).toDouble(),
      description: data['description'] ?? "",
      coverImage: data['coverImage'] ?? "",
      homepage: data['homepage'] ?? false,
      active: data['active'] ?? true,
      images: imageMap,
      colors: colorList,
      sizes: sizeMap,
    );
  }
}