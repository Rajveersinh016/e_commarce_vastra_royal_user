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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.categoryName),
        centerTitle: true,
      ),

      body: Obx(() {

        if (controller.filteredProducts.isEmpty) {
          return const Center(child: Text("No Products Found"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.60,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (_, i) {

            final product = controller.filteredProducts[i];

            return CustomProductCard(
              image: product.coverImage,
              title: product.name,
              subtitle: product.category,
              price: product.price,
              discount: product.discount,
              //rating: product.rating.toString(),
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