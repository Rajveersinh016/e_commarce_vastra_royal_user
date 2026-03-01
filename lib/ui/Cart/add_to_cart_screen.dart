import 'package:e_commarce_kk/ui/Custom_Widget/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  int qty1 = 1;
  int qty2 = 1;
  int qty3 = 1;

  Widget priceRow(String title, String price,
      {bool big = false, bool blue = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight:
                  big ? FontWeight.bold : FontWeight.normal)),
          Text(price,
              style: TextStyle(
                  color: blue ? Colors.blue : Colors.black,
                  fontWeight:
                  big ? FontWeight.bold : FontWeight.normal,
                  fontSize: big ? 20 : 14)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,


      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: const Text(
          "YOUR ATELIER BAG",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "3 Items",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          )
        ],
      ),


      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [

                const SizedBox(height: 10),


                CartItem(
                  image: "lib/assets/images/Man.png",
                  title: "Hand-Embroidered Silk Sherwani",
                  subtitle: "Royal Gold | Size XL",
                  price: "₹2,450.00",
                  qty: qty1,
                  onAdd: () => setState(() => qty1++),
                  onRemove: () {
                    if (qty1 > 1) setState(() => qty1--);
                  },
                ),


                CartItem(
                  image: "lib/assets/images/Man.png",
                  title: "Velvet Bandhgala Jacket",
                  subtitle: "Midnight Blue | Size L",
                  price: "₹1,850.00",
                  qty: qty2,
                  onAdd: () => setState(() => qty2++),
                  onRemove: () {
                    if (qty2 > 1) setState(() => qty2--);
                  },
                ),


                CartItem(
                  image: "lib/assets/images/Woman.png",
                  title: "Ivory Tussar Silk Safa",
                  subtitle: "Ivory | Standard",
                  price: "₹450.00",
                  qty: qty3,
                  onAdd: () => setState(() => qty3++),
                  onRemove: () {
                    if (qty3 > 1) setState(() => qty3--);
                  },
                ),


                priceRow("Subtotal", "₹4,750.00"),
                priceRow("Shipping", "COMPLIMENTARY",
                    blue: true),
                priceRow("Estimated Tax", "₹380.00"),

                const Divider(),

                priceRow(
                  "TOTAL",
                  "₹5,130.00",
                  big: true,
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "PROCEED TO CHECKOUT",
                  style: TextStyle(
                    color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



  
  


}
