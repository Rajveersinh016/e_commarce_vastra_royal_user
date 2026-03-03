import 'package:e_commarce_kk/ui/Home/Bottom_navigation/bottom_navogation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  //String get uid => FirebaseAuth.instance.currentUser!.uid;

  String? get uid => FirebaseAuth.instance.currentUser?.uid;

  var loading = false.obs;

  Future signup(String email, String password, String Phone, String name) async {

    try {
      loading(true);

      UserCredential credential = await firebaseAuth.createUserWithEmailAndPassword
        (
          email: email,
          password: password
      );

      await databaseReference.child("users").child(credential.user!.uid).set({
        "email": email,
        "Phone": Phone,
        "name": name,
      });

      Get.snackbar("success", "Account Created");
      Get.to(
          () => BottomNavogation(),
          transition: Transition.rightToLeft,
          duration: Duration(seconds: 1)
      );

    }
    catch (e) {
      Get.snackbar("Error", e.toString());
    }
    finally {
      loading(false);
    }


  }


  Future signin (String email, String password) async {

    try {
      loading(true);

      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      if(userCredential.user != null){
        Get.snackbar("Success", "Login Successful",backgroundColor: Colors.green,colorText: Colors.white);
        Get.to(
            () => BottomNavogation(),
            transition: Transition.rightToLeft,
            duration: Duration(seconds: 1),

        );
      }
    } on FirebaseAuthException catch (e) {
      String message = "Login Faild";

      if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided for that user.";
      }

      Get.snackbar("Error", message,backgroundColor: Colors.red,colorText: Colors.white);
    }
    finally {
      loading(false);
    }
  }

  Future forgotpassword(String email) async{
    if(email.isEmpty){
      Get.snackbar("Error", "Enter the email to reset password");
      return;
    }

    try{

      await firebaseAuth.sendPasswordResetEmail(email: email.trim());

      Get.snackbar(
          "Reset email sent",
          "check your email to reset password",
          backgroundColor: Colors.green,
          colorText: Colors.white
      );
    }
    on FirebaseAuthException catch(e){
      String message = "Error";

      if(e.code == 'user-not-found'){
        message = "No user found for that email.";
      }
      else if(e.code == 'wrong-password'){
        message = "Wrong password provided for that user.";
      }

      Get.snackbar("Error", message,backgroundColor: Colors.red,colorText: Colors.white);

    }
  }









}



