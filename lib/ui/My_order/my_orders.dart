import 'package:e_commarce_kk/ui/Custom_Widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "My Orders",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
        children: [

          OrderCard(
            orderId: "123",
            image: "lib/assets/images/Man.png",
            title: "Silk Saree",
            subtitle: "Royal Blue",
            price: "₹1200",
            status: "DELIVERED",
            showTrack: true,
          ),

          OrderCard(
            orderId: "124",
            image: "lib/assets/images/Man.png",
            title: "Designer Kurta",
            subtitle: "Black • XL",
            price: "₹1800",
            status: "ARRIVING SOON",
            showTrack: false,
          ),

          OrderCard(
            orderId: "125",
            image: "lib/assets/images/Man.png",
            title: "Wedding Sherwani",
            subtitle: "Gold • L",
            price: "₹3500",
            status: "IN TRANSIT",
            showTrack: true,
          ),

        ],
      ),
    );
  }
}