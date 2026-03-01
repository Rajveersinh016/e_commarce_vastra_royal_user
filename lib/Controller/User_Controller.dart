import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../Models/user_model.dart';

class UserController extends GetxController{

  Rxn<UserModel> user = Rxn<UserModel>();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  
  @override
  void onInit(){
    super.onInit();
    loadUser();
  }
  
  Future loadUser() async {
    
    final currentUser = firebaseAuth.currentUser;
    
    if(currentUser == null) return;
    
    final snapshot = await databaseReference.child("users").child(currentUser.uid).get();

    if(snapshot.exists){
      user.value = UserModel.fromMap(currentUser.uid, snapshot.value as Map);
    }
    
    
  }

  Future <void> updateUser({
    required String name,
    required String email,
    required String phone,

}) async {
    final currentuser = firebaseAuth.currentUser;
    if(currentuser == null) return;

    await databaseReference
         .child("users")
         .child(currentuser.uid)
         .update({
            "name" : name,
            "email" : email,
            "phone" : phone,
    });

    user.value = user.value!.copyWith(
      name: name,
      email: email,
      phone: phone,
    );

    Get.snackbar("Success", "Profile Updated");


  }




}