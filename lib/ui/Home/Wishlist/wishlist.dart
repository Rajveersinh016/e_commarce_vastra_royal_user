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

  /// SIZE SELECTOR (UNCHANGED LOGIC)
  void showSizeSelector(BuildContext context, WishlistModel item) {

    String selectedSize = "";

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {

            List<String> sizes = ["S", "M", "L", "XL"];

            return Container(
              padding: const EdgeInsets.all(20),
              height: 240,
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
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
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
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: selectedSize.isEmpty
                          ? null
                          : () {

                        final cartProduct = CartProductModel(
                          id: item.id,
                          name: item.name,
                          price: item.price,
                          discount: item.discount,
                          images: {"default":[item.image]},
                        );

                        cartController.addToCart(
                          CartModel(
                            productModel: cartProduct,
                            selectedColor: "default",
                            selectedSize: selectedSize,
                          ),
                        );

                        wishlistController.removeFromWishlist(item.id);

                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Add To Cart",
                        style: TextStyle(color: Colors.white),
                      ),
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

  /// PREMIUM CARD
  Widget wishlistCard(WishlistModel item) {

    double finalPrice = item.price - item.discount;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [

          /// IMAGE (FIXED + COVER)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: item.image.isEmpty
                ? Image.asset(
              "lib/assets/images/Man.png",
              height: 100,
              width: 90,
              fit: BoxFit.fill,
            )
                : Image.network(
              item.image,
              height: 100,
              width: 90,
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
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Icon(Icons.favorite, color: Colors.red, size: 18),
                  ],
                ),

                const SizedBox(height: 4),

                const Text(
                  "Select size before adding to cart",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "₹${finalPrice.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  height: 40,
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

  /// EMPTY STATE
  Widget emptyWishlist() {
    return const Center(
      child: Text(
        "Your wishlist is empty 💔",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Wishlist",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AddToCartScreen(),
                  transition: Transition.rightToLeft);
            },
            icon: const Icon(Icons.shopping_cart_outlined,
                color: Colors.black),
          ),
        ],
      ),

      body: Obx(() {

        if (wishlistController.wishlistItems.isEmpty) {
          return emptyWishlist();
        }

        return ListView.builder(
          itemCount: wishlistController.wishlistItems.length,
          itemBuilder: (context, index) {
            final item = wishlistController.wishlistItems[index];
            return wishlistCard(item);
          },
        );
      }),
    );
  }
}