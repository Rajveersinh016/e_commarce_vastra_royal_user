import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Track Order",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 10),


            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [

                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage("lib/assets/images/Woman.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Silk Bandhani Saree",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        Text("Royal Blue • Hand-woven",
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 4),
                        Text("₹12,500",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),
            ),


            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("PLACED"),
                      Text("IN TRANSIT"),
                      Text("DELIVERED"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Stack(
                    children: [


                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),


                      Container(
                        height: 6,
                        width: Get.width * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Estimated Delivery: Oct 24, 2023",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),


            timelineItem(
              "Order Placed",
              "Oct 20, 2023",
              true,
            ),

            timelineItem(
              "Shipped",
              "Oct 21, 2023",
              true,
            ),

            timelineItem(
              "Out for Delivery",
              "Oct 24, 2023",
              false,
            ),

            timelineItem(
              "Delivered",
              "",
              false,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

 
  static Widget timelineItem(
      String title, String date, bool completed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Column(
            children: [
              Icon(
                completed
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: completed ? Colors.green : Colors.grey,
              ),
              Container(
                width: 2,
                height: 40,
                color: Colors.grey.shade300,
              )
            ],
          ),

          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                      completed ? Colors.black : Colors.grey)),
              Text(date,
                  style: const TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}
