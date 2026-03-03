class CartProductModel {
  final String id;
  final String name;
  final double price;
  final double discount;
  final Map<String, List<String>> images;

  CartProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.images,
  });
}