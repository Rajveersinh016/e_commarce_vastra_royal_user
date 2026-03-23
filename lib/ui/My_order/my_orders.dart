import 'package:e_commarce_kk/ui/Custom_Widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/order_controller.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  final OrderController orderController =
  Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    orderController.fetchOrders();
  }

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

      body: Obx(() {

        if (orderController.orders.isEmpty) {
          return const Center(
            child: Text("No Orders Found"),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
          itemCount: orderController.orders.length,
            itemBuilder: (context, index) {

              final order = orderController.orders[index];

              if (order.items.isEmpty) {
                return const SizedBox();
              }

              final product = order.items[0]; // this is Map now

              return OrderCard(
                orderId: order.id,
                image: product['image'] ?? "",
                title: product['name'] ?? "",
                subtitle:
                "${product['color'] ?? ""} • ${product['size'] ?? ""}",
                price: "₹${order.total}",
                status: order.status,
                showTrack: false,
              );
            }
        );
      }),
    );
  }
}