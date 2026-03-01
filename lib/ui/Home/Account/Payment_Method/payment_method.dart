import 'package:e_commarce_kk/ui/Order_Placed/Order_Placed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          Get.to(
              () => OrderPlaced(),
              transition: Transition.rightToLeft,
              duration: Duration(seconds: 1)
          );
        },
            child: Text("click")),
      ),
    );
  }
}
