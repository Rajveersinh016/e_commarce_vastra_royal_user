import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/wishlist_model.dart';

class WishlistController extends GetxController {

  final DatabaseReference _db =
  FirebaseDatabase.instance.ref("wishlists");

  String? get uid => FirebaseAuth.instance.currentUser?.uid;

  RxList<WishlistModel> wishlistItems = <WishlistModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadWishlist();
  }

  Future<void> loadWishlist() async {

    if (uid == null) return;

    wishlistItems.clear();

    final snapshot = await _db.child(uid!).get();

    if (!snapshot.exists) return;

    final data =
    Map<String, dynamic>.from(snapshot.value as Map);

    for (var entry in data.entries) {

      final value =
      Map<String, dynamic>.from(entry.value);

      wishlistItems.add(
        WishlistModel(
          id: value["productId"],
          name: value["name"],
          price: (value["price"] as num).toDouble(),
          discount: (value["discount"] as num).toDouble(),
          image: value["image"],
        ),
      );
    }
  }

  Future<void> addToWishlist(WishlistModel item) async {

    if (uid == null) return;

    await _db.child(uid!).push().set(item.toJson());

    wishlistItems.add(item);
  }

  Future<void> removeFromWishlist(String productId) async {

    final snapshot = await _db.child(uid!).get();

    if (!snapshot.exists) return;

    final data =
    Map<String, dynamic>.from(snapshot.value as Map);

    for (var entry in data.entries) {

      final value =
      Map<String, dynamic>.from(entry.value);

      if (value["productId"] == productId) {

        await _db.child(uid!).child(entry.key).remove();
        break;
      }
    }

    wishlistItems.removeWhere((item) => item.id == productId);
  }
}