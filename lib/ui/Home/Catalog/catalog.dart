import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/catalog_model.dart';
import '../../Cart/add_to_cart_screen.dart';
import '../../Product_screen/product_screen.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {

  List<String> products = [
    "Shirt",
    "Jeans",
    "Jacket",
    "T-shirt",
    "Hoodie",
    "Sweater",
  ];

  List<String> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }

  void searchProduct(String value) {
    setState(() {
      filteredProducts = products
          .where((item) =>
          item.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

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
        height: Get.height * 0.06,
        width: Get.width * 0.32,
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

//   Widget Collection_items({
//     required String image,
//     required String title,
//     required String subtitle,
//     required String price,
//
// }) {
//     return
//       Container(
//         height: Get.height*0.40,
//         width: Get.width*0.35,
//         // color: Colors.blueAccent,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           image: DecorationImage(image: AssetImage(image),fit: BoxFit.fill),
//         ),
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 158.0),
//               child: SizedBox(
//                   width: Get.height*0.20,
//                   child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),)),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18.0),
//               child: Row(
//                 children: [
//                   Text(subtitle,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//                   SizedBox(width: 5,),
//                   Text(price,style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),),
//                 ],
//               ),
//             )
//           ],
//         ),
//       );
//
//
// }


  Widget collectionItem({
    required String image,
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Container(
      height: Get.height * 0.40,
      width: Get.width * 0.35,



      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),

      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),


          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [
              Colors.black.withOpacity(0.75),
              Colors.transparent,
            ],
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 4),


            Row(
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


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





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Discover',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Text('Luxury',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
              ],
            ),
            Text('VASTRA ROYALE EXCLUSIVE',style: TextStyle(fontSize: 10,color: Colors.black54),)
          ],
        ),

        actions: [
          IconButton(onPressed: (){
            Get.to(
                    () => AddToCartScreen(),
                transition: Transition.rightToLeft,
                duration: Duration(seconds: 1)
            );
          },
              icon: Icon(Icons.shopping_cart_outlined,color: Colors.black,weight: 2,))
        ],
      ),
      body:
        ListView(
          children: [

            Column(
              children: [

                SizedBox(height: 10,),

                SizedBox(
                  height: Get.height*0.07,
                  width: Get.width*0.90,
                  child: SearchBar(
                    hintText: "Search clothes...",
                    hintStyle: MaterialStateProperty.all(
                      TextStyle(color: Colors.grey),
                    ),


                    onChanged: searchProduct, // same function

                    leading: Icon(Icons.search,color: Colors.lightBlueAccent,),

                    elevation: MaterialStateProperty.all(0), // very important
                    shadowColor: MaterialStateProperty.all(Colors.transparent),

                    backgroundColor:
                    MaterialStateProperty.all(Colors.white),

                    side: MaterialStateProperty.all(
                        BorderSide(
                          color: Colors.black12,
                          width: 1,
                        )
                    ),


                    shape: MaterialStateProperty.all(

                      RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 12),
                      productItem(title: 'Summer Gala', index: 0),
                      productItem(title: 'Winter', index: 1),
                      productItem(title: 'Luxury', index: 2),
                      productItem(title: 'Trending', index: 3),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
                
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    children: [
                      Text('Curated Collections',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      SizedBox(width: 90,),
                      TextButton(onPressed: (){},
                          child: Text('See All',style: TextStyle(color: Colors.blue,fontSize: 15),),)
                    ],
                  ),
                ),

                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                  child: GridView.builder(
                    itemCount: catalogList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
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
                  )
                )




              ],
            )



          ],
        )
    );
  }
}
