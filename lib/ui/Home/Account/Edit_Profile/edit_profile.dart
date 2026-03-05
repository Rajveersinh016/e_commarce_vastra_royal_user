import 'dart:io';

import 'package:e_commarce_kk/Controller/User_Controller.dart';
import 'package:e_commarce_kk/ui/Home/Account/Shipping_Address/Edit_Address/edit_address.dart';
import 'package:e_commarce_kk/ui/Home/Account/account_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Custom_Widget/Profile_header.dart';
import '../../../Custom_Widget/text_filed_and_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  
  final usercontroller = Get.find<UserController>();

  File? image_file;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(
        source:ImageSource.gallery
    );

    //print("RESULT: $picked");

    if(picked != null){
      setState(() {
        image_file = File(picked.path);
      });
    }

  }

  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// fill instantly if already loaded
    final user = usercontroller.user.value;
    if (user != null) {
      namecontroller.text = user.name;
      emailcontroller.text = user.email;
      phonecontroller.text = user.phone;
    }

    /// listen for future updates
    usercontroller.user.listen((user) {
      if (user != null) {
        namecontroller.text = user.name;
        emailcontroller.text = user.email;
        phonecontroller.text = user.phone;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Get.back();
        },
            icon:Icon(Icons.keyboard_arrow_left,size: 30,)),
        title: Padding(
          padding: const EdgeInsets.only(left: 58.0),
          child: Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        ),

      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child:Column(
          children: [
            SizedBox(height: 20,),

            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [


                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amber, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: image_file != null
                          ? FileImage(image_file!)
                          : usercontroller.user.value?.profileImage != null &&
                          usercontroller.user.value!.profileImage.isNotEmpty
                          ? NetworkImage(usercontroller.user.value!.profileImage)
                          : const AssetImage("lib/assets/images/Man.png")
                          as ImageProvider,
                    ),
                  ),


                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 18),
                      ),
                    ),
                  ),

                ],

              ),
              
              
            ),
            Text("Change Profile Image",style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.bold),),

            SizedBox(height: 30,),
            AppFormField(
              title: 'Name',
              hint: 'Katherine King',
              icon: Icons.person,
              controller: namecontroller,


            ),
            SizedBox(height: 15,),

            AppFormField(title: "Email Address", hint:"example@gmail.com", icon:Icons.mail, controller: emailcontroller),

            SizedBox(height: 15,),

            AppFormField(title: "Phone Number", hint: "+91 987456123", icon: Icons.phone, controller: phonecontroller),

            SizedBox(height: 50,),

            SizedBox(
              height: 50,
              child: AppFormButton(title: "Save Changes", icon: Icons.check_circle
                  , onTap: (){
                      usercontroller.updateUser(
                          name: namecontroller.text.trim(),
                          email: emailcontroller.text.trim(),
                          phone: phonecontroller.text.trim(),
                          imagePath: image_file?.path,
                      );
                  }
              ),
            )

          ],
        )
      ),
      

    );
  }
}
