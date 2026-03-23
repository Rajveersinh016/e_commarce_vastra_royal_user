import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {

  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.ref().child("orders");

  late Razorpay razorpay;

  Map selectedAddress = {};
  List cartItems = [];
  String userId = "";
  String userName = "";
  String userEmail = "";
  double paidAmount = 0;

  @override
  void onInit() {
    super.onInit();

    razorpay = Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentsuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentfailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void openCheckout(
      double amount,
      Map address,
      List items,
      String uid,
      String name,
      String email,
      ) {
    paidAmount = amount;

    selectedAddress = address;
    cartItems = items;
    userId = uid;
    userName = name;
    userEmail = email;

    var options = {
      'key': 'rzp_test_SPPynqp1mcFLgF',
      'amount': (amount * 100).toInt(),
      'name': 'Vastra Royal',
      'description': 'Clothing Purchase',
      'prefill': {
        'contact': '9876543210',
        'email': email
      }
    };

    razorpay.open(options);
  }

  void paymentsuccess(PaymentSuccessResponse response) async {

    String paymentId = response.paymentId ?? "";

    await saveOrderToFirebase(paymentId);

    Get.snackbar("Payment Success", "Order Placed Successfully");

    /// 🔥 CLEAR CART (IMPORTANT)
    // Get.find<CartController>().clearCart();

    /// 🔥 NAVIGATION
    Get.offAllNamed("/home");
  }

  void paymentfailure(PaymentFailureResponse response) {
    Get.snackbar("Payment Failed", response.message ?? "Error");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet", response.walletName ?? "Error");
  }

  @override
  void onClose() {
    razorpay.clear();
    super.onClose();
  }

  Future<void> saveOrderToFirebase(String paymentId) async {

    String orderId = databaseReference.push().key!;

    List products = cartItems.map((item) => {
      "productId": item.productModel.id,
      "name": item.productModel.name,
      "price": item.productModel.price,
      "discount": item.productModel.discount,
      "quantity": item.quantity,
      "size": item.selectedSize,
      "color": item.selectedColor,
      "image": item.productModel.images.values.first.first
    }).toList();

    await databaseReference
        .child(userId) // 🔥 IMPORTANT CHANGE
        .child(orderId)
        .set({

      "orderId": orderId,
      "userId": userId,
      "userName": userName,
      "userEmail": userEmail,
      "address": selectedAddress,
      "products": products,
      "paymentId": paymentId,
      "paymentMethod": "razorpay",
      "totalAmount": paidAmount,
      "status": "PLACED",
      "orderTime": DateTime.now().millisecondsSinceEpoch

    });
  }
}