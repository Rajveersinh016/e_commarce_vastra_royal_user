import 'package:e_commarce_kk/Colors/colors.dart';
import 'package:e_commarce_kk/Controller/cart_controller.dart';
import 'package:e_commarce_kk/Controller/product_controller.dart';
import 'package:e_commarce_kk/ui/Cart/add_to_cart_screen.dart';
import 'package:e_commarce_kk/ui/Custom_Widget/Auto_scroll_widget.dart';
import 'package:e_commarce_kk/ui/Custom_Widget/Custom_product_card.dart';
import 'package:e_commarce_kk/ui/Product_Detail/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Category/category_products_screen.dart';
import '../../Custom_Widget/Home_custome_cart.dart';
import '../../Drawer/drawer.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // List<String> products = [
  //   "Shirt",
  //   "Jeans",
  //   "Jacket",
  //   "T-shirt",
  //   "Hoodie",
  //   "Sweater",
  // ];
  //
  // List<String> filteredProducts = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   filteredProducts = products;
  // }
  //
  // void searchProduct(String value) {
  //   setState(() {
  //     filteredProducts = products
  //         .where((item) =>
  //         item.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  int selectedIndex = 0;

  // Widget categoryItem({
  //   required String image,
  //   required String title,
  //   required int index,
  // }) {
  //   bool selected = selectedIndex == index;
  //
  //
  //
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         selectedIndex = index;
  //       });
  //     },
  //   child:  Column(
  //     children: [
  //
  //
  //       Container(
  //         height: 70,
  //         width: 70,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           border: Border.all(
  //             color: selected ? Colors.blue : Colors.grey.shade300,
  //             width: 2,
  //           ),
  //         ),
  //         child: ClipOval(
  //             child: Image.asset(
  //               image,
  //               fit: BoxFit.fill,
  //             ),
  //           ),
  //
  //       ),
  //
  //       SizedBox(height: 6),
  //
  //       Text(
  //         title,
  //         style: TextStyle(
  //           color: selected ? Colors.blue : Colors.grey,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //     ],
  //   )
  //   );
  // }

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
            ),
          ),
        ],
      ),
    );
  }






 final ProductController productController = Get.put(ProductController());

  final CartController cartController = Get.put(CartController());






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white,






        shadowColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.shade300, // line color
          ),
        ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer(); //  open drawer
              },
            ),
          ),

          //icon: Icon(Icons.menu,color: Colors.black,)),
        title:Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
              Container(
                height: Get.height*0.05,
                width: Get.width*0.10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent
                ),
                child: Center(child: Text('v',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),)),
              ),
              SizedBox(width: 5,),
              Text('Vastra Royal',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 25),)
            ],
          ),
        ) ,
        actions: [
          IconButton(onPressed: (){
            Get.to(
                () => AddToCartScreen(),
                transition: Transition.rightToLeft,
                duration: Duration(seconds: 1)
            );
          }, icon: Icon(Icons.shopping_cart_outlined,color: Colors.black,)),
        ],


      ),

      body:
      ListView(
        children: [

          Column(

            children: [

              SizedBox(height: 20,),


              SizedBox(
                height: Get.height*0.07,
                width: Get.width*0.90,
                child: SearchBar(
                  hintText: "Search clothes...",

                  onChanged: productController.search, // same function

                  leading: Icon(Icons.search),

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

                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Container(
                height: Get.height*0.40,
                width: Get.width*0.90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: AssetImage('lib/assets/images/Home_model.png'),fit: BoxFit.fill)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width*0.40,
                          child: Text('Royal Summer Elegance',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                          SizedBox(width:250,child: Text('Experience luxury with our new season arrivals',style: TextStyle(color: Colors.white),)),
                          SizedBox(
                            width: Get.width*0.70,
                            child: ElevatedButton(onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.blueAccent,
                                ),
                                child: Text('Shop Now',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                          )

                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),
              Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 210.0),
                    child: Text('Categories',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 2,),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          categoryItem(image: 'lib/assets/images/Woman.png', title:"Women's Ethnic" , index: 0),
                          SizedBox(width: 8,),
                          categoryItem(image: 'lib/assets/images/Man.png', title:"Men's Ethnic", index: 1),
                          SizedBox(width: 8),
                          categoryItem(image: 'lib/assets/images/Accessories.png', title:'Accessories', index: 2),
                          SizedBox(width: 8),
                          categoryItem(image: 'lib/assets/images/Shoes.png', title:'Shoes', index: 3),
                          SizedBox(width: 8),
                          categoryItem(image: 'lib/assets/images/Watch.png', title:'Watch', index: 4),
                          SizedBox(width: 8),
                          categoryItem(image: 'lib/assets/images/glasses.png', title:'Glasses', index: 5),
                          SizedBox(width: 8),


                        ],
                      ),

                    ),
                  )
                ],
              ),
              
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  children: [
                    Text('New Arrivals',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(width: 130,),
                    TextButton(onPressed: (){},
                        child: Text('See All',style: TextStyle(color: Colors.blue,fontSize: 15),))
                  ],
                ),
              ),
              SizedBox(height: 10,),


              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Obx(() {

                  if(productController.isLoading.value){
                    return const Center(child: CircularProgressIndicator());
                  }

                  if(productController.homeProducts.isEmpty){
                    return const Center(child: Text("No Products Found"));
                  }

                  return GridView.builder(
                    itemCount: productController.homeProducts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (_, i){

                      final product = productController.homeProducts[i];

                      return CustomProductCard(
                        image: product.coverImage,
                        title: product.name,
                        subtitle: product.category,
                        price: product.price,
                        discount: product.discount,

                        //rating: product.rating.toString(),
                        onTap: () {
                          Get.to(
                              () => ProductDetail(
                                product: product,
                          )

                          );
                        },
                      );
                    },
                  );
                }),
              )




              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   child: GridView.count(
              //     crossAxisCount: 2,
              //     shrinkWrap: true,
              //     childAspectRatio: 0.65,
              //     physics: NeverScrollableScrollPhysics(),
              //     children: [
              //       CustomProductCard(
              //           image: 'lib/assets/images/Man.png',
              //           title: 'Man wear',
              //           subtitle: "Man's Formal",
              //           price: '250.00',
              //           rating: '4.5',
              //           onTap: (){
              //             Get.to(()=> ProductDetail(product: product));
              //            },
              //
              //       ),
              //       CustomProductCard(
              //           image: 'lib/assets/images/Woman.png',
              //           title: 'Woman wear',
              //           subtitle: "Woman's wear",
              //           price: '250.00',
              //           rating: '4.5',
              //         onTap: (){
              //           Get.to(()=> ProductDetail(product: product));
              //         },
              //
              //       ),
              //       CustomProductCard(
              //           image: 'lib/assets/images/Watch.png',
              //           title: 'Watch',
              //           subtitle: "Watch",
              //           price: '250.00',
              //           rating: '4.5',
              //         onTap: (){
              //           Get.to(()=> ProductDetail(product: product));
              //         },
              //       ),
              //     ],
              //   ),
              // )








            ],
          )


        ],
      ) ,
    );
  }
}


