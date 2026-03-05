class WishlistModel {
  final String id;
  final String name;
  final double price;
  final double discount;
  final String image;

  WishlistModel({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": id,
      "name": name,
      "price": price,
      "discount": discount,
      "image": image,
    };
  }
}