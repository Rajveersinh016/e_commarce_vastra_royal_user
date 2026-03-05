import 'package:e_commarce_kk/ui/Custom_Widget/text_filed_and_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Controller/address_controller.dart';
import '../../../../../models/address_model.dart';


class EditAddress extends StatefulWidget {
  const EditAddress({super.key});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {

  final addressController = Get.find<AddressController>();

  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final addrescontroller1 = TextEditingController();
  final addresscontroller2 = TextEditingController();
  final citycontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final zipcodecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(left:55),
          child: Text("Edit Address"),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:10,right:10),
          child: Column(
            children: [

              const SizedBox(height:20),

              AppFormField(
                title: "Full Name",
                hint: "Alexander Vastra",
                icon: Icons.person,
                controller: namecontroller,
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height:10),

              AppFormField(
                title: "Phone Number",
                hint: "+91 9876543210",
                icon: Icons.phone,
                controller: phonecontroller,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height:10),

              AppFormField(
                title: "Address Line 1",
                hint: "123 Main Street",
                icon: Icons.location_on,
                controller: addrescontroller1,
              ),

              const SizedBox(height:10),

              AppFormField(
                title: "Address Line 2",
                hint: "Apartment 456",
                icon: Icons.location_on,
                controller: addresscontroller2,
              ),

              const SizedBox(height:10),

              Row(
                children: [

                  Expanded(
                    child: AppFormField(
                      title: "City",
                      hint: "Surat",
                      icon: Icons.location_city,
                      controller: citycontroller,
                    ),
                  ),

                  const SizedBox(width:10),

                  Expanded(
                    child: AppFormField(
                      title: "State",
                      hint: "Gujarat",
                      icon: Icons.landscape,
                      controller: statecontroller,
                    ),
                  ),

                ],
              ),

              const SizedBox(height:10),

              AppFormField(
                title: "Zip Code",
                hint: "395007",
                icon: Icons.pin_drop,
                controller: zipcodecontroller,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height:20),

              SizedBox(
                height:50,
                child: AppFormButton(
                  title: "Save Address",
                  icon: Icons.check_circle,
                  onTap: () {

                    final address = AddressModel(
                      id: "",
                      name: namecontroller.text.trim(),
                      phone: phonecontroller.text.trim(),
                      line1: addrescontroller1.text.trim(),
                      line2: addresscontroller2.text.trim(),
                      city: citycontroller.text.trim(),
                      state: statecontroller.text.trim(),
                      zipcode: zipcodecontroller.text.trim(),
                    );

                    addressController.addAddress(address);

                    Get.back();

                  },
                ),
              ),

              const SizedBox(height:20),

            ],
          ),
        ),
      ),
    );
  }
}