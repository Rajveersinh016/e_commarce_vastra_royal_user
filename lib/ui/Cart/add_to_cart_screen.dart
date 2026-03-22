import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/cart_controller.dart';
import '../Checkout/Checkout.dart';
import '../Custom_Widget/cart_items.dart';

class AddToCartScreen extends StatelessWidget {
  AddToCartScreen({super.key});

  final CartController cartController = Get.find<CartController>();

  Widget priceRow(String title, String price,
      {bool big = false, bool blue = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: big ? FontWeight.bold : FontWeight.w500,
              fontSize: big ? 16 : 13,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              color: blue ? Colors.blue : Colors.black,
              fontWeight: big ? FontWeight.bold : FontWeight.w500,
              fontSize: big ? 18 : 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_bag_outlined,
              size: 60, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            "Your bag is empty",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "YOUR BAG",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() => Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "${cartController.cartItems.length} items",
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ))
        ],
      ),

      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return emptyCart();
        }

        return Column(
          children: [

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 100),
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {

                  final item = cartController.cartItems[index];

                  return CartItem(
                    image: item.productModel.images.isNotEmpty
                        ? item.productModel.images.values.first.first
                        : "",
                    title: item.productModel.name,
                    subtitle:
                    "${item.selectedColor} • ${item.selectedSize}",
                    price: "₹${item.totalPrice}",
                    qty: item.quantity,
                    onAdd: () {
                      cartController.increaseQty(index);
                    },
                    onRemove: () {
                      cartController.removeItem(index);
                    },
                  );
                },
              ),
            ),

            Obx(() {
              double subtotal = cartController.subtotal;

              return Container(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [

                    const Divider(),

                    priceRow(
                      "Subtotal",
                      "₹${subtotal.toStringAsFixed(0)}",
                    ),

                    priceRow(
                      "Shipping",
                      "FREE",
                      blue: true,
                    ),

                    const Divider(),

                    priceRow(
                      "TOTAL",
                      "₹${subtotal.toStringAsFixed(0)}",
                      big: true,
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => CheckoutScreen(
                            items: cartController.cartItems,
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "PROCEED TO CHECKOUT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      }),
    );
  }
}