import 'dart:io';

import 'package:e_commarce_kk/Controller/User_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Custom_Widget/text_filed_and_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final usercontroller = Get.find<UserController>();

  File? imageFile;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final user = usercontroller.user.value;
    if (user != null) {
      namecontroller.text = user.name;
      emailcontroller.text = user.email;
      phonecontroller.text = user.phone;
    }

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
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            Stack(
              children: [

                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent,
                        Colors.purpleAccent,
                      ],
                    ),
                  ),
                  child: Obx(() {

                    final image =
                        usercontroller.user.value?.profileImage ?? "";

                    return CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      backgroundImage: imageFile != null
                          ? FileImage(imageFile!)
                          : image.isEmpty
                          ? const AssetImage("lib/assets/images/Man.png")
                          : NetworkImage(image) as ImageProvider,
                    );
                  }),
                ),

                Positioned(
                  bottom: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              "Change Profile Image",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 30),

            AppFormField(
              title: 'Name',
              hint: 'Katherine King',
              icon: Icons.person,
              controller: namecontroller,
            ),

            const SizedBox(height: 15),

            AppFormField(
              title: "Email Address",
              hint: "example@gmail.com",
              icon: Icons.mail,
              controller: emailcontroller,
            ),

            const SizedBox(height: 15),

            AppFormField(
              title: "Phone Number",
              hint: "+91 987456123",
              icon: Icons.phone,
              controller: phonecontroller,
            ),

            const SizedBox(height: 40),

            SizedBox(
              height: 50,
              width: double.infinity,
              child: AppFormButton(
                title: "Save Changes",
                icon: Icons.check_circle,
                onTap: () {
                  usercontroller.updateUser(
                    name: namecontroller.text.trim(),
                    email: emailcontroller.text.trim(),
                    phone: phonecontroller.text.trim(),
                    imagePath: imageFile?.path,
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}