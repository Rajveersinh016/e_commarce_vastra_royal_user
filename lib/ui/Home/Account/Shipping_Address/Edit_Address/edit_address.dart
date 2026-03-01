import 'package:e_commarce_kk/ui/Custom_Widget/text_filed_and_button.dart';
import 'package:flutter/material.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({super.key});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {

  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final addrescontroller1 = TextEditingController();
  final addresscontroller2 = TextEditingController();
  final citycontroller = TextEditingController();
  final pincodecontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final zipcodecontroller = TextEditingController();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 55.0),
          child: Text('Edit Address'),
        ),

      ),
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [

                SizedBox(height: 20,),
                AppFormField(title: "Full Name", hint: "Alexander Vastra", icon: Icons.person, controller: namecontroller,keyboardType: TextInputType.text,),

                SizedBox(height: 10,),

                AppFormField(title: "Phone Number", hint: "+91 9773227698", icon: Icons.phone, controller: phonecontroller,keyboardType: TextInputType.phone,),
                SizedBox(height: 10,),

                AppFormField(title: "Address Line 1", hint: "123 Main Street", icon: Icons.location_on, controller: addrescontroller1),

                SizedBox(height: 10,),

                AppFormField(title: "Address Line 2", hint: "Apartment 456", icon: Icons.location_on, controller: addresscontroller2),

                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(

                    children: [
                      SizedBox(
                          width: 150,
                          child: AppFormField(title: "City", hint: "Surat", icon: Icons.location_city, controller: citycontroller)),
                          SizedBox(width: 10,),
                          SizedBox(
                              width: 150,
                              child: AppFormField(title: "State", hint: "Gujarat", icon: Icons.landscape, controller: statecontroller)),



                    ],
                  ),
                ),

                SizedBox(height: 10,),

                AppFormField(title: "Zip Code", hint: "90012", icon: Icons.control_point_duplicate, controller: zipcodecontroller,keyboardType: TextInputType.phone,),



                SizedBox(height: 10,),
                SizedBox(
                    height: 50,
                    child: AppFormButton(title: "Save Address", icon: Icons.check_circle, onTap: (){})),

                SizedBox(height: 20,),



              ],
            ),
          ),
        ) ,
    );
  }
}
