import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/cart_controller.dart';
import '../Checkout/Checkout.dart';
import '../Custom_Widget/cart_items.dart';

class AddToCartScreen extends StatelessWidget {
  AddToCartScreen({super.key});

  final CartController cartController =
  Get.find<CartController>();

  Widget priceRow(
      String title,
      String price, {
        bool big = false,
        bool blue = false,
      }) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight:
              big ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              color: blue ? Colors.blue : Colors.black,
              fontWeight:
              big ? FontWeight.bold : FontWeight.normal,
              fontSize: big ? 20 : 14,
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
          icon:
          const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "YOUR ATELIER BAG",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        // ✅ Dynamic Item Count
        actions: [
          Obx(() => Padding(
            padding:
            const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "${cartController.cartItems.length} Items",
                style: const TextStyle(
                    color: Colors.blue),
              ),
            ),
          ))
        ],
      ),

      body: Column(
        children: [


          Expanded(
            child: Obx(() {

              if (cartController.cartItems.isEmpty) {
                return const Center(
                  child: Text(
                    "Your bag is empty",
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                );
              }

              return ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {

                  final item = cartController.cartItems[index];

                  return CartItem(
                    image: item.productModel.images.isNotEmpty
                        ? item.productModel.images.values.first.first
                        : "",
                    title: item.productModel.name,
                    subtitle: "${item.selectedColor} • ${item.selectedSize}",
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
              );


            }),
          ),

          // =========================
          // PRICE SUMMARY SECTION
          // =========================
          Obx(() {

            double subtotal =
                cartController.subtotal;

            return Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 20),
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
                    "COMPLIMENTARY",
                    blue: true,
                  ),

                  const Divider(),

                  priceRow(
                    "TOTAL",
                    "₹${subtotal.toStringAsFixed(0)}",
                    big: true,
                  ),

                  const SizedBox(height: 12),

                  Padding(
                    padding:
                    const EdgeInsets.symmetric(
                        horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed:(){
                          Get.to(() => CheckoutScreen(
                            items: cartController.cartItems,
                          ));


                        // cartController.cartItems.isEmpty
                        //     ? null
                        //     : () {
                        //   Get.snackbar(
                        //     "Checkout",
                        //     "Proceeding to checkout",
                        //     snackPosition:
                        //     SnackPosition.BOTTOM,
                        //   );
                        },
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.blue,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "PROCEED TO CHECKOUT",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}