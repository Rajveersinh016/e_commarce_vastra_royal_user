import 'package:e_commarce_kk/Colors/colors.dart';
import 'package:e_commarce_kk/Models/product_model.dart';
import 'package:e_commarce_kk/ui/Checkout/Checkout.dart';
import 'package:e_commarce_kk/ui/Home/Home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductDetail extends StatefulWidget {
  // const ProductDetail({super.key});
  final ProductModel product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {



  List<String> images = [
    'lib/assets/images/Man.png',
    'lib/assets/images/Shoes.png',
    'lib/assets/images/Gold.png',
  ];

  PageController controller = PageController();
  int currentindex = 0;

  bool isFavorite = false;

  int selectedIndex = 0;


  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.blue,

  ];



  Widget Color_Item({
    required Color color,
    required int index,
  }) {
    bool selected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });




      },
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? Colors.orange : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: color,
              
              child: selected
                ? Icon(Icons.check,color: Colors.white,)
                : null,

            ),
            


          ),
        ],
      ),
    );
  }



  int selectedSizeIndex = 0;


  Widget Size_Item({
    required String title,
    required int index,
  }) {
    bool selected = selectedSizeIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSizeIndex = index;
        });
      },
      child: Container(
        height: Get.height * 0.06,
        width: Get.width * 0.20,
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Get.back();
        },
            icon: Icon(Icons.keyboard_arrow_left,color: Colors.black,size: 40,)),
        actions: [
          Row(
            children: [
              IconButton(onPressed: (){}, icon:Icon(Icons.share,color: Colors.black,size: 25,)),
              IconButton(onPressed: (){}, icon:Icon(Icons.shopping_cart,color: Colors.black,size: 25,)),

            ],
          )
        ],

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: controller,
                itemCount: images.length,

                onPageChanged:(index){
                  setState(() {
                    currentindex = index;
                  });
                },

                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(images[index]),
                      ),
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: IconButton(onPressed: (){
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Colors.red
                                    : Colors.grey,
                              )
                          ),
                        )
                      ],
                    ) ,
                  );
                },

              ),



            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index){
                return Container(
                  margin: const EdgeInsets.all(4),

                  width: currentindex == index ? 14:8,
                  height: 8,

                  decoration: BoxDecoration(
                    color: currentindex == index
                        ? Colors.blueAccent
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                children: [

                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Text("Royal Wear",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                      SizedBox(width: 110,),
                      Column(
                        children: [
                          Text("₹700",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.blueAccent),),
                          Text("₹1200",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey,decoration: TextDecoration.lineThrough),),

                        ],
                      )
                    ],
                  ),

                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Text("COLOR:",style: TextStyle(color: Colors.black,fontSize:15,fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Text("Royal Blue",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold,fontSize: 15),)
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 12,
                        children: List.generate(colors.length, (index){
                          return Color_Item(color: colors[index], index: index);
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),

                  Row(
                    children: [
                      Text("SELECT SIZE",style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Size_Item(title: 'S', index: 0),
                        Size_Item(title: 'M', index: 1),
                        Size_Item(title: 'L', index: 2),
                        Size_Item(title: 'XL', index: 3),
                        Size_Item(title: 'XXL', index: 4),
                        Size_Item(title: 'XXXL', index: 5),


                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    width: Get.width*0.900,
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.grey.shade100, // light grey background
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Text(
                      "Crafted from premium Italian velvet, this blazer features a modern slim fit cut that perfectly balances comfort and style. The gold-tone buttons add a touch of regal elegance suitable for evening events.",

                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5, // line spacing
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),








                ],
              ),
            )





          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [

            /// ADD TO CART BUTTON
            SizedBox(
              height: 50,
              width: Get.width*0.40,
              child: Expanded(

                child: OutlinedButton.icon(
                  onPressed: () {},

                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text("ADD TO CART"),

                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),

                    side: const BorderSide(color: Colors.blue, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    foregroundColor: Colors.blue,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),


            SizedBox(
              height: 50,
              width: Get.width*0.45,
              child: Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                        () => CheckoutScreen(),
                       transition: Transition.rightToLeft,
                      duration: Duration(seconds: 1),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),

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
            ),
          ],
        ),
      ),




    );

  }
}
