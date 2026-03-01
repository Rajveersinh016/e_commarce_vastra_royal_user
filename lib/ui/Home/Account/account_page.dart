import 'package:e_commarce_kk/Colors/colors.dart';
import 'package:e_commarce_kk/ui/Custom_Widget/Profile_header.dart';
import 'package:e_commarce_kk/ui/Home/Account/Payment_Method/payment_method.dart';
import 'package:e_commarce_kk/ui/Home/Account/Shipping_Address/shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Edit_Profile/edit_profile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Profile',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){},
              icon: Icon(Icons.notifications_none,color: Colors.black,))
        ],
      ),
      body: ListView(
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10,),
              Center(child: ProfileHeader()),

              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Container(
                      height: Get.height*0.10,
                      width: Get.width*0.40,
                      decoration: BoxDecoration(
                        color:Appcolor.light_grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("12",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 25),),
                            Text("ORDERS",style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),

                    ),
                    SizedBox(width: 20,),

                    Container(
                      height: Get.height*0.10,
                      width: Get.width*0.40,
                      decoration: BoxDecoration(
                        color:Appcolor.light_grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("240",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 25),),
                            Text("POINTS",style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),

                    ),

                  ],
                ),
              ),
              
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 21.0),
                child: Text("ACCOUNT",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child : InkWell(
                  onTap: (){
                    Get.to(
                      () => EditProfile(),
                      transition: Transition.rightToLeft,
                      duration: Duration(seconds: 1),
                    );
                  },
                    child: Container(
                      height: Get.height*0.08,
                      width: Get.width*0.85,
                      decoration: BoxDecoration(
                        color:Appcolor.light_grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.person,color: Colors.blueAccent,),
                          SizedBox(width: 50,),
                          Text("Edit Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          SizedBox(width: 100,),
                          Icon(Icons.arrow_forward_ios,color: Colors.grey,)

                        ],

                      ),
                    ),
                ),

              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: InkWell(
                  onTap: (){
                    Get.to(
                      () => ShippingAddress(),
                      transition: Transition.rightToLeft,
                      duration: Duration(seconds: 1),

                    );
                  },
                  child:Container(
                  height: Get.height*0.08,
                  width: Get.width*0.85,
                  decoration: BoxDecoration(
                    color:Appcolor.light_grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Icon(Icons.fire_truck,color: Colors.blueAccent,),
                      SizedBox(width: 50,),
                      Text("Shipping Address",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      SizedBox(width: 60,),
                      Icon(Icons.arrow_forward_ios,color: Colors.grey,)

                    ],

                  ),
                ),
                ),
              ),


              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: InkWell(
                  onTap: (){
                    Get.to(
                      () => PaymentMethod(),
                      transition: Transition.rightToLeft,
                      duration: Duration(seconds: 1),


                    );
                  },
                    child: Container(
                      height: Get.height*0.08,
                      width: Get.width*0.85,
                      decoration: BoxDecoration(
                        color:Appcolor.light_grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.credit_card_outlined,color: Colors.blueAccent,),
                          SizedBox(width: 50,),
                          Text("Payment Method",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          SizedBox(width: 60,),
                          Icon(Icons.arrow_forward_ios,color: Colors.grey,)

                        ],

                      ),
                    ),
                ),
              )

            ],


          )
        ],
      ),
    );
  }
}
