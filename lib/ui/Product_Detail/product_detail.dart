import 'package:e_commarce_kk/Colors/colors.dart';
import 'package:e_commarce_kk/models/product_model.dart';
import 'package:e_commarce_kk/ui/Checkout/Checkout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/cart_controller.dart';
import '../../models/cart_model.dart';

class ProductDetail extends StatefulWidget {
  final ProductModel product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  // ==============================
  //  OLD STATIC IMAGES (REMOVED)
  // ==============================
  /*
  List<String> images = [
    'lib/assets/images/Man.png',
    'lib/assets/images/Shoes.png',
    'lib/assets/images/Gold.png',
  ];
  */

  // ==============================
  //  NEW DYNAMIC IMAGE VARIABLES
  // ==============================
  late List<String> images;
  String selectedColor = "";
  int selectedColorIndex = 0;

  PageController pageController = PageController();
  int currentIndex = 0;

  bool isFavorite = false;

  // ==============================
  // INIT STATE → LOAD FIRST COLOR
  // ==============================
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

    // ==============================
    //  PRICE CALCULATION
    // ==============================
    double finalPrice =
        widget.product.price - widget.product.discount;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.keyboard_arrow_left,
              color: Colors.black, size: 40),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // ==============================
            //  REAL FIREBASE IMAGE SLIDER
            // ==============================
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: pageController,
                itemCount: images.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        //  OLD → AssetImage
                        // image: AssetImage(images[index]),

                        //  NEW → NetworkImage
                        image: NetworkImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            // ==============================
            // DOT INDICATOR
            // ==============================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  width: currentIndex == index ? 14 : 8,
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

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ==============================
                  //  REAL PRODUCT NAME
                  // ==============================
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ==============================
                  // REAL DISCOUNT PRICING
                  // ==============================
                  Row(
                    children: [

                      Text(
                        "₹${finalPrice.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.blueAccent,
                        ),
                      ),

                      const SizedBox(width: 10),

                      if (widget.product.discount > 0)
                        Text(
                          "₹${widget.product.price.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),

                      const SizedBox(width: 10),

                      if (widget.product.discount > 0)
                        Text(
                          "${((widget.product.discount / widget.product.price) * 100).toStringAsFixed(0)}% off",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ==============================
                  //  COLOR SECTION (DYNAMIC)
                  // ==============================
                  const Text(
                    "SELECT COLOR",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

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
                                .images[selectedColor] ??
                                [];
                            currentIndex = 0;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selected
                                  ? Colors.orange
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: color,
                            child: selected
                                ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  //Size section

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
                              vertical: 12, horizontal: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
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
                          child: Column(
                            children: [
                              Text(
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
                              if (outOfStock)
                                const Text(
                                  "Out",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),





                  const SizedBox(height: 25),

                  // ==============================
                  // ✅ REAL DESCRIPTION
                  // ==============================
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.product.description,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),

      // ==============================
      // BUY SECTION
      // ==============================
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: selectedSize.isEmpty
                          ? null
                          : () {
                           Get.to(() => CheckoutScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                  EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "BUY NOW",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(width: 10,),

            SizedBox(
              width: 160,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: selectedSize.isEmpty
                    ? null
                    : () {
                  cartController.addToCart(
                    CartModel(
                      productModel: widget.product,
                      selectedColor: selectedColor,
                      selectedSize: selectedSize,
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),

                ),

                icon: const Icon(Icons.shopping_cart_outlined,color: Colors.blue,),
                label: const Text("ADD TO CART",style: TextStyle(color: Colors.blue),),
              ),
            )


          ],
        ),
      ),
    );
  }
}