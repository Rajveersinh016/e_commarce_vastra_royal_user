import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      source: ImageSource.gallery,
    );

    if (picked != null) {
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

                final image = userController.user.value?.profileImage ?? "";

                return CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: image.isEmpty
                      ? const AssetImage("lib/assets/images/Man.png")
                      : NetworkImage(image) as ImageProvider,
                );
              }),
            ),

            GestureDetector(
              onTap: pickImage,
              child: Container(
                margin: const EdgeInsets.only(right: 4, bottom: 4),
                padding: const EdgeInsets.all(6),
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
                  size: 16,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Obx(() => Text(
          userController.user.value?.name ?? "Loading...",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        )),

        const SizedBox(height: 4),

        Obx(() => Text(
          userController.user.value?.email ?? "Loading...",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        )),

        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.amber.withOpacity(0.15),
          ),
          child: const Text(
            "GOLD MEMBER",
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),

      ],
    );
  }
}