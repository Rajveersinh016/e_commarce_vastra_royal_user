import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class UserController extends GetxController {

  Rxn<UserModel> user = Rxn<UserModel>();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  // ⭐ Load user from Firebase
  Future loadUser() async {

    final currentUser = firebaseAuth.currentUser;

    if (currentUser == null) return;

    final snapshot = await databaseReference
        .child("users")
        .child(currentUser.uid)
        .get();

    if (snapshot.exists) {
      user.value =
          UserModel.fromMap(currentUser.uid, snapshot.value as Map);
    }
  }

  // ⭐ Update user profile
  Future<void> updateUser({
    required String name,
    required String email,
    required String phone,
    String? imagePath,
  }) async {

    final currentuser = firebaseAuth.currentUser;

    if (currentuser == null) return;

    String imageUrl = user.value?.profileImage ?? "";

    /// ⭐ Upload image if selected
    if (imagePath != null) {

      File file = File(imagePath);

      final storageRef = FirebaseStorage.instance
          .ref()
          .child("profile_images")
          .child("${currentuser.uid}.jpg");

      await storageRef.putFile(file);

      imageUrl = await storageRef.getDownloadURL();
    }

    /// ⭐ Update Firebase database
    await databaseReference
        .child("users")
        .child(currentuser.uid)
        .update({
      "name": name,
      "email": email,
      "phone": phone, // fixed key (was Phone)
      "profileImage": imageUrl,
    });

    /// ⭐ Reload user from database to avoid null crash
    await loadUser();

    Get.snackbar("Success", "Profile Updated");
  }

}