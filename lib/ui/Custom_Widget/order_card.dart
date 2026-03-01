import 'package:e_commarce_kk/ui/My_order/track_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String image;
  final String title;
  final String subtitle;
  final String price;
  final String status; // arriving, delivered, transit
  final bool showTrack;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.status,
    this.showTrack = false,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor =
    status == "DELIVERED" ? Colors.green : Colors.orange;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ]
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ORDER ID + STATUS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ORDER ID\n$orderId",
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),

          const SizedBox(height: 10),

          /// IMAGE + TITLE
          Row(
            children: [

              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                    Text(subtitle,
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(price,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// BUTTONS
          if (showTrack)
            Row(
              children: [

                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    onPressed: () {
                      Get.to(
                          () => TrackOrder(),
                        transition: Transition.rightToLeft,
                        duration: Duration(seconds: 1),
                      );
                    },
                    icon: const Icon(Icons.local_shipping,color: Colors.white,),
                    label: const Text("Track Order",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),

                    child: const Text("Details",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            )
          else
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("Order Details"),
              ),
            )
        ],
      ),
    );
  }
}
