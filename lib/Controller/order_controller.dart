import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../models/order_model.dart';

class OrderController extends GetxController {

  final DatabaseReference orderRef =
  FirebaseDatabase.instance.ref("orders");

  RxList<OrderModel> orders = <OrderModel>[].obs;


  Future<void> placeOrder({
    required List items,
    required double total,
  }) async {

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final orderId = orderRef.push().key;

    final order = OrderModel(
      id: orderId!,
      userId: user.uid,
      items: items,
      total: total,
      status: "PLACED",
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    await orderRef
        .child(user.uid)
        .child(orderId)
        .set(order.toMap());
  }


  void fetchOrders() {

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    orderRef.child(user.uid).onValue.listen((event) {

      final data = event.snapshot.value;

      if (data == null) {
        orders.clear();
        return;
      }

      Map map = data as Map;

      List<OrderModel> temp = [];

      map.forEach((key, value) {
        temp.add(OrderModel.fromMap(value));
      });

      orders.value = temp.reversed.toList();
    });
  }
}