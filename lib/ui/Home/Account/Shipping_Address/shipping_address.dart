import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/address_controller.dart';

import 'Edit_Address/edit_address.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {

  final addressController = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text('Shipping Address'),
        ),
        leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.keyboard_arrow_left,size: 30)
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:18,right:18,top:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "SAVED ADDRESSES",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height:20),


              Obx(() {

                if(addressController.addresses.isEmpty){
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top:50),
                      child: Text(
                        "No address saved",
                        style: TextStyle(fontSize:16),
                      ),
                    ),
                  );
                }

                return ListView.builder(

                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: addressController.addresses.length,

                  itemBuilder: (context,index){

                    final address =
                    addressController.addresses[index];

                    return GestureDetector(


                      onTap: (){
                        addressController
                            .setDefault(address.id);
                      },

                      child: Container(

                        margin:
                        const EdgeInsets.only(bottom:20),

                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: address.isDefault
                                ? Colors.blue
                                : Colors.grey.shade300,
                            width: address.isDefault ? 2 : 1,
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [


                            Row(
                              children: [

                                Expanded(
                                  child: Text(
                                    address.name,
                                    style: const TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize:16),
                                  ),
                                ),

                                if(address.isDefault)
                                  Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal:8,
                                        vertical:4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                      BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      "DEFAULT",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:12),
                                    ),
                                  )

                              ],
                            ),

                            const SizedBox(height:10),


                            Text(address.line1),
                            Text(address.line2),

                            Text(
                                "${address.city}, ${address.state}"
                            ),

                            Text("Zip: ${address.zipcode}"),

                            const SizedBox(height:10),


                            Row(
                              children: [

                                const Icon(
                                  Icons.phone,
                                  size:18,
                                  color: Colors.grey,
                                ),

                                const SizedBox(width:5),

                                Text(
                                  address.phone,
                                  style: const TextStyle(
                                      color: Colors.grey),
                                ),

                                const Spacer(),


                                IconButton(
                                  icon: const Icon(
                                      Icons.delete_outline),
                                  onPressed: (){
                                    addressController
                                        .deleteAddress(
                                        address.id);
                                  },
                                )

                              ],
                            )

                          ],
                        ),
                      ),
                    );
                  },
                );
              })

            ],
          ),
        ),
      ),


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(

          width: Get.width*0.60,
          height: Get.height*0.06,

          child: ElevatedButton(

            onPressed: (){
              Get.to(
                      () => const EditAddress(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 400)
              );
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            child: const Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [

                Icon(Icons.location_pin,color: Colors.white),

                SizedBox(width:6),

                Text(
                  "Add New Address",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )

              ],
            ),
          ),
        ),
      ),

    );
  }
}