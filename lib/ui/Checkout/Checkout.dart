import 'package:e_commarce_kk/Controller/payment_controller.dart';
import 'package:e_commarce_kk/ui/Home/Account/Payment_Method/payment_method.dart';
import 'package:e_commarce_kk/ui/Home/Account/Shipping_Address/shipping_address.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/address_controller.dart';
import '../../Controller/order_controller.dart';
import '../../models/cart_model.dart';

class CheckoutScreen extends StatelessWidget {

  final List<CartModel> items;

  CheckoutScreen({super.key, required this.items});

  final addressController = Get.find<AddressController>();

  final PaymentController paymentController = Get.put(PaymentController());

  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {

    double subtotal = items.fold(
        0,
            (sum, item) =>
        sum +
            ((item.productModel.price -
                item.productModel.discount) *
                item.quantity));

    double tax = subtotal * 0.08;
    double total = subtotal + tax;

    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back,
                color: Colors.black)),
        title: const Text(
          "Checkout",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// STEP INDICATOR
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              stepCircle("Cart", true),
              stepLine(),
              stepCircle("Details", false,
                  active: true),
              stepLine(),
              stepCircle("Done", false),
            ],
          ),

          const SizedBox(height: 25),

          /// ADDRESS TITLE
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "SHIPPING ADDRESS",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => ShippingAddress());
                },
                child: const Text("Change"),
              )
            ],
          ),

          const SizedBox(height: 10),

          /// ADDRESS BOX
          Obx(() {

            if (addressController.addresses
                .isEmpty) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(16),
                ),
                child:
                const Text("No address selected"),
              );
            }

            final address = addressController
                .addresses
                .firstWhere((a) => a.isDefault,
                orElse: () =>
                addressController
                    .addresses.first);

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(16),
                border: Border.all(
                    color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(address.name,
                      style: const TextStyle(
                          fontWeight:
                          FontWeight.bold)),

                  const SizedBox(height: 6),

                  Text(address.line1),
                  Text(address.line2),

                  Text(
                      "${address.city}, ${address.state}"),

                  Text("Zip: ${address.zipcode}"),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.phone,
                          size: 16,
                          color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(address.phone),
                    ],
                  )
                ],
              ),
            );
          }),

          const SizedBox(height: 25),

          /// BAG TITLE
          Text(
            "MY BAG (${items.length})",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),

          const SizedBox(height: 12),

          /// PRODUCTS
          ListView.builder(
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {

              final item = items[index];
              final product = item.productModel;

              //final image = product.images.values.first.first;

              String image = "";

              if (product.images.isNotEmpty) {
                final imageList = product.images.values.first;

                if (imageList.isNotEmpty) {
                  image = imageList.first;
                }
              }


              return bagItem(
                product.name,
                "${item.selectedColor} • Size ${item.selectedSize}",
                (product.price -
                    product.discount)
                    .toStringAsFixed(0),
                image,
                item.quantity,
              );
            },
          ),

          const SizedBox(height: 25),

          /// SUMMARY
          summaryCard(subtotal, tax, total),
        ],
      ),

      /// PLACE ORDER
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {

              final user = FirebaseAuth.instance.currentUser;

              final address = addressController.addresses.firstWhere(
                    (a) => a.isDefault,
                orElse: () => addressController.addresses.first,
              );

              paymentController.openCheckout(
                  total,
                  //addressController.addresses.first.toJson(),
                  address.toJson(),
                  items,
                  user?.uid ?? "",
                  user?.displayName ?? "User",
                  user?.email ?? ""
              );

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(14)),
            ),
            child: const Text(
              "Place Order",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  /// STEP CIRCLE
  Widget stepCircle(String title, bool done,
      {bool active = false}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: done || active
              ? Colors.blue
              : Colors.grey.shade300,
          child: done
              ? const Icon(Icons.check,
              color: Colors.white, size: 18)
              : Text(active ? "2" : ""),
        ),
        const SizedBox(height: 5),
        Text(title,
            style: TextStyle(
                color:
                active ? Colors.blue : Colors.grey)),
      ],
    );
  }

  Widget stepLine() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey.shade300,
      ),
    );
  }

  /// BAG ITEM
  Widget bagItem(String title, String sub,
      String price, String image, int qty) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [

          image.isEmpty
              ? Image.asset("lib/assets/images/Man.png", width: 70)
              : image.startsWith("http")
              ? Image.network(image, width: 70)
              : Image.asset(image, width: 70),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight:
                          FontWeight.bold)),
                  Text(sub,
                      style: const TextStyle(
                          color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text("₹$price",
                      style: const TextStyle(
                          fontWeight:
                          FontWeight.bold)),
                ]),
          ),

          Text("x$qty",
              style:
              const TextStyle(color: Colors.grey))
        ],
      ),
    );
  }

  /// SUMMARY
  Widget summaryCard(
      double subtotal, double tax, double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text("Subtotal"),
              Text(subtotal.toStringAsFixed(2)),
            ],
          ),

          const SizedBox(height: 8),

          const Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping"),
              Text("Free",
                  style:
                  TextStyle(color: Colors.green)),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tax (8%)"),
              Text(tax.toStringAsFixed(2)),
            ],
          ),

          const Divider(),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Amount",
                  style: TextStyle(
                      fontWeight: FontWeight.bold)),
              Text(
                total.toStringAsFixed(2),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}