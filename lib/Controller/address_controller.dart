import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/address_model.dart';

class AddressController extends GetxController {

  final DatabaseReference db =
  FirebaseDatabase.instance.ref("addresses");

  //final String uid = FirebaseAuth.instance.currentUser!.uid;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  RxList<AddressModel> addresses = <AddressModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
  }


  Future<void> loadAddresses() async {

    final snapshot = await db.child(uid!).get();

    if(snapshot.exists){

      final data = Map<String,dynamic>.from(snapshot.value as Map);

      addresses.value = data.entries.map((e){

        return AddressModel.fromMap(
            e.key,
            Map<String,dynamic>.from(e.value)
        );

      }).toList();

    }

  }


  Future<void> addAddress(AddressModel address) async {

    final newRef = db.child(uid!).push();

    await newRef.set(address.toJson());

    loadAddresses();

  }


  Future<void> deleteAddress(String id) async {

    await db.child(uid!).child(id).remove();

    loadAddresses();

  }


  Future<void> updateAddress(AddressModel address) async {

    await db.child(uid!).child(address.id).update(address.toJson());

    loadAddresses();

  }


  Future<void> setDefault(String id) async {

    final snapshot = await db.child(uid!).get();

    if(!snapshot.exists) return;

    final data = Map<String,dynamic>.from(snapshot.value as Map);

    for(var entry in data.entries){

      await db.child(uid!).child(entry.key).update({
        "isDefault": entry.key == id
      });

    }

    loadAddresses();

  }

}