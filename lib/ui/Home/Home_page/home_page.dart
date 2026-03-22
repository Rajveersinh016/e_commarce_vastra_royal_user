import 'package:e_commarce_kk/Colors/colors.dart';
import 'package:e_commarce_kk/Controller/address_controller.dart';
import 'package:e_commarce_kk/Controller/cart_controller.dart';
import 'package:e_commarce_kk/Controller/product_controller.dart';
import 'package:e_commarce_kk/Controller/wishlist_controller.dart';
import 'package:e_commarce_kk/ui/Cart/add_to_cart_screen.dart';
import 'package:e_commarce_kk/ui/Product_Detail/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Category/category_products_screen.dart';
import '../../Custom_Widget/Custom_product_card.dart';
import '../../Drawer/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;

  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  final WishlistController wishlistController = Get.put(WishlistController());
  final AddressController addressController = Get.put(AddressController());

  /// CATEGORY ITEM
  Widget categoryItem({
    required String image,
    required String title,
    required int index,
  }) {
    bool selected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        Get.to(() => CategoryProductsScreen(categoryName: title));
      },
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? Colors.blue : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(image, fit: BoxFit.fill),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: selected ? Colors.blue : Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        title: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent,
              ),
              child: const Center(
                child: Text(
                  'V',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Vastra Royal',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AddToCartScreen(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 400));
            },
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          ),
        ],
      ),

      /// BODY
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [

            const SizedBox(height: 10),

            /// SEARCH BAR
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: productController.search,
                decoration: const InputDecoration(
                  hintText: "Search clothes...",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// BANNER
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('lib/assets/images/Home_model.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Royal Summer Elegance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Experience luxury with our new arrivals',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Shop Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// CATEGORY TITLE
            const Text(
              "Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// CATEGORY LIST
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categoryItem(image: 'lib/assets/images/Woman.png', title: "Women's Ethnic", index: 0),
                  const SizedBox(width: 10),
                  categoryItem(image: 'lib/assets/images/Man.png', title: "Men's Ethnic", index: 1),
                  const SizedBox(width: 10),
                  categoryItem(image: 'lib/assets/images/Accessories.png', title: 'Accessories', index: 2),
                  const SizedBox(width: 10),
                  categoryItem(image: 'lib/assets/images/Shoes.png', title: 'Shoes', index: 3),
                  const SizedBox(width: 10),
                  categoryItem(image: 'lib/assets/images/Watch.png', title: 'Watch', index: 4),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// NEW ARRIVALS HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "New Arrivals",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("See All"),
                )
              ],
            ),

            const SizedBox(height: 10),

            /// PRODUCT GRID
            Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (productController.homeProducts.isEmpty) {
                return const Center(child: Text("No Products Found"));
              }

              return GridView.builder(
                itemCount: productController.homeProducts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (_, i) {
                  final product = productController.homeProducts[i];

                  return CustomProductCard(
                    image: product.coverImage,
                    title: product.name,
                    subtitle: product.category,
                    price: product.price,
                    discount: product.discount,
                    onTap: () {
                      Get.to(() => ProductDetail(product: product));
                    },
                  );
                },
              );
            }),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}