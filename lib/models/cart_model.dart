import 'product_model.dart';

class CartModel {
  final ProductModel productModel;
  final String selectedColor;
  final String selectedSize;
  int quantity;

  CartModel({
    required this.productModel,
    required this.selectedColor,
    required this.selectedSize,
    this.quantity = 1,
  });

  double get totalPrice =>
      (productModel.price - productModel.discount) * quantity;

  Map<String, dynamic> toJson() {
    return {
      "productId": productModel.id,
      "color": selectedColor,
      "size": selectedSize,
      "quantity": quantity,
    };
  }
}