import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/cart_controller.dart';
import '../../../Controller/wishlist_controller.dart';
import '../../../models/cart_model.dart';
import '../../../models/cart_product_model.dart';
import '../../../models/wishlist_model.dart';
import '../../Cart/add_to_cart_screen.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  final wishlistController = Get.find<WishlistController>();
  final cartController = Get.find<CartController>();


  /// =============================
  /// SIZE SELECTOR
  /// =============================
  void showSizeSelector(BuildContext context, WishlistModel item) {

    String selectedSize = "";

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {

            List<String> sizes = ["S", "M", "L", "XL"];

            return Container(
              padding: const EdgeInsets.all(20),
              height: 230,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Select Size",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Wrap(
                    spacing: 10,
                    children: sizes.map((size) {

                      bool selected = selectedSize == size;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                            color: selected
                                ? Colors.blue
                                : Colors.white,
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: selectedSize.isEmpty
                          ? null
                          : () {

                        /// create cart product
                        final cartProduct = CartProductModel(
                          id: item.id,
                          name: item.name,
                          price: item.price,
                          discount: item.discount,
                          images: {"default":[item.image]},
                        );

                        /// add to cart
                        cartController.addToCart(
                          CartModel(
                            productModel: cartProduct,
                            selectedColor: "default",
                            selectedSize: selectedSize,
                          ),
                        );

                        /// remove from wishlist
                        wishlistController.removeFromWishlist(item.id);

                        Navigator.pop(context);
                      },
                      child: const Text("Add To Cart",style: TextStyle(color: Colors.white),),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }


  /// =============================
  /// WISHLIST CARD
  /// =============================
  Widget wishlistCard(WishlistModel item) {

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        children: [

          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: item.image.isEmpty
                ? Image.asset(
              "lib/assets/images/Man.png",
              height: 90,
              width: 80,
              fit: BoxFit.fill,
            )
                : Image.network(
              item.image,
              height: 90,
              width: 80,
              fit: BoxFit.fill,
            ),
          ),

          const SizedBox(width: 12),

          /// DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),

                    const Icon(Icons.favorite, color: Colors.amber),
                  ],
                ),

                const SizedBox(height: 4),

                const Text(
                  "Select size when moving to cart",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "₹${(item.price - item.discount).toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 8),

                /// MOVE TO CART BUTTON
                SizedBox(
                  height: 36,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showSizeSelector(context, item);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    icon: const Icon(Icons.shopping_bag,
                        size: 16, color: Colors.white),

                    label: const Text(
                      "Move to Cart",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  /// =============================
  /// SCREEN UI
  /// =============================
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: const Text("My Wishlist"),

        actions: [
          IconButton(
            onPressed: () {

              Get.to(
                    () => AddToCartScreen(),
                transition: Transition.rightToLeft,
                duration: const Duration(seconds: 1),
              );

            },
            icon: const Icon(Icons.shopping_cart_outlined,
                color: Colors.black),
          ),
        ],
      ),


      body: Obx(() {

        if (wishlistController.wishlistItems.isEmpty) {
          return const Center(
            child: Text("No items in wishlist"),
          );
        }

        return ListView.builder(
          itemCount: wishlistController.wishlistItems.length,

          itemBuilder: (context, index) {

            final item =
            wishlistController.wishlistItems[index];

            return wishlistCard(item);
          },
        );
      }),
    );
  }
}