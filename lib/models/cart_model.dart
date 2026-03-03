import 'cart_product_model.dart';
import 'product_model.dart';

class CartModel {
  final CartProductModel productModel;
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
      "name": productModel.name,
      "price": productModel.price,
      "discount": productModel.discount,
      "images": productModel.images,
      "color": selectedColor,
      "size": selectedSize,
      "quantity": quantity,
    };
  }
}