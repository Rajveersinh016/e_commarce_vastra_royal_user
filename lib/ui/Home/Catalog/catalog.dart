import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/catalog_model.dart';
import '../../Cart/add_to_cart_screen.dart';
import '../../Product_screen/product_screen.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {

  int selectedIndex = 0;

  List<CatalogModel> catalogList = [
    CatalogModel(
      title: "Summer Gala",
      image: "lib/assets/images/Royal_suit.png",
      tag: "summer",
    ),
    CatalogModel(
      title: "Winter",
      image: "lib/assets/images/Evening_grows.png",
      tag: "winter",
    ),
    CatalogModel(
      title: "Luxury",
      image: "lib/assets/images/Gold.png",
      tag: "luxury",
    ),
    CatalogModel(
      title: "Trending",
      image: "lib/assets/images/Royal_suit.png",
      tag: "trending",
    ),
  ];

  /// FILTER CHIP
  Widget filterChip({
    required String title,
    required int index,
  }) {
    bool selected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.blueAccent : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// COLLECTION CARD (PREMIUM)
  Widget collectionItem({
    required String image,
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [

            /// IMAGE
            Positioned.fill(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),

            /// GRADIENT
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            /// TEXT
            Positioned(
              left: 12,
              bottom: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Text(
                  'Discover ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Luxury',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              'VASTRA ROYALE EXCLUSIVE',
              style: TextStyle(fontSize: 10, color: Colors.black54),
            )
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
          )
        ],
      ),

      /// BODY
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [

          const SizedBox(height: 10),

          /// SEARCH BAR (MODERN)
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search collections...",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// FILTERS
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                filterChip(title: 'Summer', index: 0),
                filterChip(title: 'Winter', index: 1),
                filterChip(title: 'Luxury', index: 2),
                filterChip(title: 'Trending', index: 3),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Curated Collections',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("See All"),
              )
            ],
          ),

          const SizedBox(height: 10),

          /// GRID (FIXED HEIGHT SAFE)
          GridView.builder(
            itemCount: catalogList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 220, // 🔥 NO OVERFLOW EVER
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {

              var catalog = catalogList[index];

              return GestureDetector(
                onTap: () {
                  Get.to(
                        () => ProductScreen(tag: catalog.tag),
                    transition: Transition.rightToLeft,
                  );
                },
                child: collectionItem(
                  image: catalog.image,
                  title: catalog.title,
                  subtitle: "Starting at",
                  price: "₹2500",
                ),
              );
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}