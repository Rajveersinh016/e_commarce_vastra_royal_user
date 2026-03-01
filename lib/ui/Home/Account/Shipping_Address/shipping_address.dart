import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../account_page.dart';
import 'Edit_Address/edit_address.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text('Shipping Address'),
        ),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.keyboard_arrow_left,size: 30,)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 180.0),
                child: Text('SAVED ADDRESSES',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
              ),

              SizedBox(height: 30,),

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
              )


            ],
          ),
        )
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: Get.width*0.60,
          height: Get.height*0.06,
          child: ElevatedButton(onPressed: (){
            Get.to(
                    () => EditAddress(),
                transition:Transition.rightToLeft,
                duration: Duration(milliseconds: 1000)
            );
          },
               style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.blue,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10),

                 ),
               ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_pin,color: Colors.white,),
                    Text("Add New Address",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                  ],
                )),
        ),
      )

    );
  }
}
