import 'package:e_commarce_kk/models/product_model.dart';
import 'package:e_commarce_kk/ui/Checkout/Checkout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/cart_controller.dart';
import '../../models/cart_model.dart';
import '../../models/cart_product_model.dart';

class ProductDetail extends StatefulWidget {
  final ProductModel product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  late List<String> images;
  String selectedColor = "";
  int selectedColorIndex = 0;

  PageController pageController = PageController();
  int currentIndex = 0;

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    if (widget.product.images.isNotEmpty) {
      selectedColor = widget.product.images.keys.first;
      images = widget.product.images[selectedColor]!;
    } else {
      images = [];
    }
  }

  String selectedSize = "";
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {

    double finalPrice =
        widget.product.price - widget.product.discount;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(
              height: 300,
              child: Stack(
                children: [

                  PageView.builder(
                    controller: pageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        images[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),

                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          width: currentIndex == index ? 16 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? Colors.blueAccent
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Text(
                        "₹${finalPrice.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (widget.product.discount > 0)
                        Text(
                          "₹${widget.product.price.toStringAsFixed(0)}",
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const SizedBox(width: 8),
                      if (widget.product.discount > 0)
                        Text(
                          "${((widget.product.discount / widget.product.price) * 100).toStringAsFixed(0)}% OFF",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Color",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 12,
                    children: widget.product.colors
                        .asMap()
                        .entries
                        .map((entry) {

                      int index = entry.key;
                      var colorData = entry.value;

                      Color color = Color(
                        int.parse(
                            colorData['hexCode']
                                .replaceFirst('#', '0xff')),
                      );

                      bool selected =
                          selectedColorIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColorIndex = index;
                            selectedColor =
                            colorData['name'];
                            images = widget.product
                                .images[selectedColor] ?? [];
                            currentIndex = 0;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selected
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: color,
                            radius: 18,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Size",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: widget.product.sizes.entries.map((entry) {

                      String size = entry.key;
                      int stock = entry.value;

                      bool selected = selectedSize == size;
                      bool outOfStock = stock == 0;

                      return GestureDetector(
                        onTap: outOfStock
                            ? null
                            : () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: selected
                                    ? Colors.blue
                                    : Colors.grey),
                            color: outOfStock
                                ? Colors.grey.shade300
                                : selected
                                ? Colors.blue
                                : Colors.white,
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: outOfStock
                                  ? Colors.grey
                                  : selected
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.product.description,
                      style: const TextStyle(height: 1.5),
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [

            Expanded(
              child: ElevatedButton(
                onPressed: selectedSize.isEmpty
                    ? null
                    : () {
                  Get.to(() => CheckoutScreen(
                    items: [
                      CartModel(
                        productModel: CartProductModel(
                          id: widget.product.id,
                          name: widget.product.name,
                          price: widget.product.price,
                          discount: widget.product.discount,
                          images: widget.product.images,
                        ),
                        selectedColor: selectedColor,
                        selectedSize: selectedSize,
                        quantity: 1,
                      )
                    ],
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                  const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("BUY NOW",
                    style: TextStyle(color: Colors.white)),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: OutlinedButton(
                onPressed: selectedSize.isEmpty
                    ? null
                    : () {

                  final cartProduct = CartProductModel(
                    id: widget.product.id,
                    name: widget.product.name,
                    price: widget.product.price,
                    discount: widget.product.discount,
                    images: widget.product.images,
                  );

                  cartController.addToCart(
                    CartModel(
                      productModel: cartProduct,
                      selectedColor: selectedColor,
                      selectedSize: selectedSize,
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blueAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "ADD TO CART",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}