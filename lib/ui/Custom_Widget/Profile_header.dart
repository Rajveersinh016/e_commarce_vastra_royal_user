import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controller/User_Controller.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {

  final userController = Get.find<UserController>();


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



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        const SizedBox(height: 20),

        Stack(
          alignment: Alignment.bottomRight,
          children: [


            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.amber, width: 3),
              ),
              child: Obx(() {

                final image = userController.user.value?.profileImage ?? "";

                return CircleAvatar(
                  radius: 50,
                  backgroundImage: image.isEmpty
                      ? const AssetImage("lib/assets/images/Man.png")
                      : NetworkImage(image) as ImageProvider,
                );
              }),
            ),


            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: GestureDetector(
            //     onTap: pickImage,
            //     child: Container(
            //       padding: const EdgeInsets.all(8),
            //       decoration: const BoxDecoration(
            //         color: Colors.blue,
            //         shape: BoxShape.circle,
            //       ),
            //       child: const Icon(Icons.edit, color: Colors.white, size: 18),
            //     ),
            //   ),
            // )
          ],
        ),

        const SizedBox(height: 10),

        Obx(() => Text(
          userController.user.value?.name ?? "Loading...",
          style: const TextStyle(
              //color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )),

        Obx(() => Text(
          userController.user.value?.email ?? "Loading...",
          style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold),
        )),

        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.amber),
          ),
          child: const Text(
            "GOLD MEMBER",
            style: TextStyle(color: Colors.amber),
          ),
        ),

      ],



    );
  }
}
