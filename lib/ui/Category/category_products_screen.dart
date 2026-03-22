import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/product_controller.dart';
import '../Custom_Widget/Custom_product_card.dart';
import '../Product_Detail/product_detail.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryName;

  const CategoryProductsScreen({super.key, required this.categoryName});

  @override
  State<CategoryProductsScreen> createState() =>
      _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {

  final ProductController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.filterCategory(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Obx(() {

        if (controller.filteredProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.search_off,
                    size: 60, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  "No Products Found",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
          itemCount: controller.filteredProducts.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            mainAxisExtent: 260,
          ),
          itemBuilder: (_, i) {

            final product = controller.filteredProducts[i];

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
    );
  }
}