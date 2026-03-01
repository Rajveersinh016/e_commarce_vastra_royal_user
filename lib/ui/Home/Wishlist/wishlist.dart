import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Cart/add_to_cart_screen.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  int selectedIndex = 0;


  Widget productItem({
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
      child: Container(
        height: Get.height * 0.05,
        width: Get.width * 0.28,
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(50),
          color: selected ? Colors.blueAccent : Colors.white,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }




  Widget cartProductCard({
    required String image,
    required String title,
    required String size,
    required String price,
  }) {
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


          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  height: 90,
                  width: 80,
                  fit: BoxFit.fill,
                ),
              ),



            ],
          ),

          const SizedBox(width: 12),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    const Icon(Icons.favorite,
                        color: Colors.amber),
                  ],
                ),

                const SizedBox(height: 4),


                Text(
                  "Size: $size",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),


                const SizedBox(height: 6),


                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 8),

                /// BUTTON
                SizedBox(
                  height: 36,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3F6FD9),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10),
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 58.0),
          child: Center(child: Text('My Wishlist')),
        ),

        actions: [
          IconButton(onPressed: (){

            Get.to(
                    () => AddToCartScreen(),
                transition: Transition.rightToLeft,
                duration: Duration(seconds: 1)
            );

          },
              icon: Icon(Icons.shopping_cart_outlined,color: Colors.black,)),
        ],
      ),
      body: ListView(
        children: [
          
          Column(
            children: [
              SizedBox(height: 10,),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                Row(
                  children: [
                    productItem(title: "All items", index: 0),
                    productItem(title: "Available", index: 1),
                    productItem(title: "On Sale", index: 2),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              cartProductCard(
                  image: 'lib/assets/images/Man.png',
                  title: "Royal Wear",
                  size: "42",
                  price: "120"),
              cartProductCard(
                  image: 'lib/assets/images/Woman.png',
                  title: "Royal Wear",
                  size: "42",
                  price: "120")

              
              
            ],
          )
          
        ],
      ),
    );
  }
}
