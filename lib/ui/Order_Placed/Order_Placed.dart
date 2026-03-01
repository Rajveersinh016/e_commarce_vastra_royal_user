import 'package:e_commarce_kk/ui/Home/Home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class OrderPlaced extends StatefulWidget {
  const OrderPlaced({super.key});

  @override
  State<OrderPlaced> createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
         leading: IconButton(onPressed: (){
           Get.to(
               () => HomePage(),
           );
         },
             icon:Icon(Icons.close))
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 100,),

          Center(
            child: Lottie.asset(
              'lib/assets/Animation/success.json',
              height: 150,
              width: 150,
            ),
          ),

          SizedBox(height: 10,),
          Text("Order Confirmed!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
          SizedBox(height:2,),
          SizedBox(
            width: 290,
              child: Text("Thank you for choosing Vastra Royale. Ypur regal attire is being prepared by our master tailors.",style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,)
          ),

          SizedBox(height: 40,),

          SizedBox(
            width: 290,
            height: 50,
            child: ElevatedButton(onPressed: (){
              Get.to(
                  () => HomePage(),
              );
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      Text("Continue Shopping",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      SizedBox(width: 2,),
                      Icon(Icons.shopping_bag,color: Colors.white,)
                    ],
                  ),
                )
            ),
          )

        ],
      )
    );
  }
}
