import 'package:e_commarce_kk/ui/Home/Account/Payment_Method/payment_method.dart';
import 'package:e_commarce_kk/ui/Home/Account/Shipping_Address/shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:  IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: Colors.black)),
        title:Padding(
          padding: const EdgeInsets.only(left: 58.0),
          child: Text(
            "Checkout",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),


      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              stepCircle("Cart", true),
              stepLine(),
              stepCircle("Details", false, active: true),
              stepLine(),
              stepCircle("Done", false),
            ],
          ),

           SizedBox(height: 25),

         
          Row(
            children: [
              Text("SHIPPING ADDRESS",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
              SizedBox(width: 120,),
              TextButton(onPressed: (){
                Get.to(
                    () => ShippingAddress(),
                     transition: Transition.rightToLeft,
                     duration: Duration(seconds: 1)
                );
              }, child: Text("Change",style: TextStyle(color: Colors.blue),))
            ],
          ),

          const SizedBox(height: 10),

          Container(
            height: Get.height*0.20,
            width: Get.width*0.90,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),

            child: Padding(
              padding: const EdgeInsets.only(left: 10.0,top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [


                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.work_outline, color: Colors.blue),
                      ),

                      const SizedBox(width: 12),


                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "John Doe",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Work Office",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),


                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_outlined),
                      ),


                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),


                  const Text(
                    "789 Empire Tower, Business District",
                    style: TextStyle(color: Colors.black87),
                  ),
                  const Text(
                    "Los Angeles, CA 90001, USA",
                    style: TextStyle(color: Colors.black87),
                  ),

                  const SizedBox(height: 12),


                  Row(
                    children: const [
                      Icon(Icons.phone, size: 18, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "+1 234 567 8901",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),


           SizedBox(height: 25),


           Text(
            "MY BAG (2)",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),

          SizedBox(height: 12),

          bagItem(
            "Velvet Evening Gown",
            "Black • Size M",
            "1,299.00",
            "lib/assets/images/Woman.png",
          ),

          bagItem(
            "Royal Silk Scarf",
            "Gold • One Size",
            "145.00",
            "lib/assets/images/Watch.png",
          ),

          SizedBox(height: 25),






          summaryCard(),


        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Get.to(
                  () => PaymentMethod(),
                  transition: Transition.rightToLeft,
                  duration: Duration(seconds: 1)

              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            child: const Text(
              "Place Order ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }


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
              ? const Icon(Icons.check, color: Colors.white, size: 18)
              : Text(
            active ? "2" : "",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 5),
        Text(title,
            style: TextStyle(
                color: active ? Colors.blue : Colors.grey)),
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


  Widget sectionTitle(String title, {String? action}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey)),
        if (action != null)
          Text(action,
              style: const TextStyle(color: Colors.blue)),
      ],
    );
  }



  Widget bagItem(
      String title, String sub, String price, String image) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Image.asset(image, width: 70),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold)),
                  Text(sub,
                      style: const TextStyle(
                          color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(price,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold)),
                ]),
          ),
          const Text("x1", style: TextStyle(color: Colors.grey))
        ],
      ),
    );
  }



  Widget summaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: const [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal"),
              Text("1,444.00"),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping"),
              Text("Free", style: TextStyle(color: Colors.green)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text("Tax (8%)"),
              Text("115.52"),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Amount",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("1,559.52",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }
}
