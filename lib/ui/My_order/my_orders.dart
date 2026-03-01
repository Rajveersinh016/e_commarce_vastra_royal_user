import 'package:e_commarce_kk/ui/Custom_Widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.keyboard_arrow_left,color: Colors.black,size: 40,)),
          title: Padding(
            padding: const EdgeInsets.only(left: 58.0),
            child: Text("My Orders",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
          ),

        ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            OrderCard(orderId: "123", image: "lib/assets/images/Man.png", title:"Silk saree", subtitle: "Royal Blue", price: "1200", status: "DELIVERED",showTrack: true, ),
            OrderCard(orderId: "123", image: "lib/assets/images/Man.png", title:"Silk saree", subtitle: "Royal Blue", price: "1200", status: "ARRIVING SOON",showTrack: false, ),
          ],
        )
      ),
    );
  }
}
