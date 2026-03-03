import 'package:get/get.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {

  RxList<CartModel> cartItems = <CartModel>[].obs;


  void addToCart(CartModel item) {

    int index = cartItems.indexWhere((element) =>
    element.productModel.id == item.productModel.id &&
        element.selectedSize == item.selectedSize &&
        element.selectedColor == item.selectedColor);

    if (index >= 0) {
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(item);
    }

    Get.snackbar(
      "Added to Cart",
      "Item added successfully",
      duration: const Duration(seconds: 1),
    );
  }

  void increaseQty(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decreaseQty(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    }
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  double get subtotal =>
      cartItems.fold(
          0, (sum, item) => sum + item.totalPrice);

}