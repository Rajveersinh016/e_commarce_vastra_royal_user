import 'dart:async';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/cart_model.dart';
import 'product_controller.dart';

class CartController extends GetxController {

  final DatabaseReference _db =
  FirebaseDatabase.instance.ref("carts");

  final String uid =
      FirebaseAuth.instance.currentUser!.uid;

  RxList<CartModel> cartItems = <CartModel>[].obs;

  @override
  void onInit() {
    loadCart();
    super.onInit();
  }

  // =============================
  // LOAD CART FROM FIREBASE
  // =============================
  Future<void> loadCart() async {

    cartItems.clear();

    final snapshot = await _db.child(uid).get();

    if (snapshot.exists) {
      final data =
      Map<String, dynamic>.from(snapshot.value as Map);

      final productController =
      Get.find<ProductController>();

      for (var entry in data.entries) {

        final value =
        Map<String, dynamic>.from(entry.value);

        final product = productController.allProducts
            .firstWhere(
              (p) => p.id == value["productId"],
        );

        cartItems.add(
          CartModel(
            productModel: product,
            selectedColor: value["color"],
            selectedSize: value["size"],
            quantity: value["quantity"],
          ),
        );
      }
    }
  }

  // =============================
  // ADD TO CART
  // =============================
  Future<void> addToCart(CartModel item) async {

    int index = cartItems.indexWhere((element) =>
    element.productModel.id == item.productModel.id &&
        element.selectedColor == item.selectedColor &&
        element.selectedSize == item.selectedSize);

    if (index >= 0) {

      cartItems[index].quantity++;
      await updateQuantity(cartItems[index]);
      cartItems.refresh();

    } else {

      cartItems.add(item);

      await _db
          .child(uid)
          .push()
          .set(item.toJson());
    }

    Get.snackbar("Cart", "Added successfully");
  }

  // =============================
  // UPDATE QUANTITY
  // =============================
  Future<void> updateQuantity(CartModel item) async {

    final snapshot = await _db.child(uid).get();

    if (!snapshot.exists) return;

    final data =
    Map<String, dynamic>.from(snapshot.value as Map);

    for (var entry in data.entries) {

      final value =
      Map<String, dynamic>.from(entry.value);

      if (value["productId"] == item.productModel.id &&
          value["color"] == item.selectedColor &&
          value["size"] == item.selectedSize) {

        await _db
            .child(uid)
            .child(entry.key)
            .update({"quantity": item.quantity});

        break;
      }
    }
  }

  // =============================
  // REMOVE ITEM
  // =============================
  Future<void> removeItem(int index) async {

    final item = cartItems[index];

    final snapshot = await _db.child(uid).get();

    if (snapshot.exists) {

      final data =
      Map<String, dynamic>.from(snapshot.value as Map);

      for (var entry in data.entries) {

        final value =
        Map<String, dynamic>.from(entry.value);

        if (value["productId"] == item.productModel.id &&
            value["color"] == item.selectedColor &&
            value["size"] == item.selectedSize) {

          await _db
              .child(uid)
              .child(entry.key)
              .remove();

          break;
        }
      }
    }

    cartItems.removeAt(index);
  }

  double get subtotal =>
      cartItems.fold(
          0, (sum, item) => sum + item.totalPrice);



  // =============================
// INCREASE QUANTITY
// =============================
  Future<void> increaseQty(int index) async {

    final item = cartItems[index];

    item.quantity++;

    await updateQuantity(item);

    cartItems.refresh();
  }


// =============================
// DECREASE QUANTITY
// =============================
  Future<void> decreaseQty(int index) async {

    final item = cartItems[index];

    if (item.quantity > 1) {

      item.quantity--;

      await updateQuantity(item);

      cartItems.refresh();

    } else {
      await removeItem(index);
    }
  }


}