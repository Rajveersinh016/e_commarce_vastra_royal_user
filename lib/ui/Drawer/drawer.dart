import 'package:e_commarce_kk/ui/Category/category_products_screen.dart';
import 'package:e_commarce_kk/ui/Login/login.dart';
import 'package:e_commarce_kk/ui/My_order/my_orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/User_Controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final usecontroller = Get.find<UserController>();
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [

            /// 🔵 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30, left: 20, bottom: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4A6EDB), Color(0xFF3E5FB6)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// PROFILE
                  Obx(() {

                    final image = usecontroller.user.value?.profileImage ?? "";

                    return CircleAvatar(
                      radius: 35,
                      backgroundImage: image.isEmpty
                          ? const AssetImage("lib/assets/images/Woman.png")
                          : NetworkImage(image) as ImageProvider,
                    );

                  }),

                  const SizedBox(height: 12),

                  Obx(() => Text(
                    usecontroller.user.value?.name ?? "Loading...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  const Text(
                    "Gold Member since 2023",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            /// 🔥 MENU LIST (SCROLLABLE)
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [

                  drawerItem(Icons.home, "Home", selected: true),
                  drawerItem(Icons.auto_awesome, "New Arrivals"),
                  drawerItem(Icons.man, "Men's Collection",
                    onTap:() {
                      Get.to(
                              () =>
                              CategoryProductsScreen(
                                  categoryName: "Men's Ethnic"),
                          transition: Transition.rightToLeft,
                          duration: Duration(seconds: 1)
                      );
                    },

                  ),
                  drawerItem(Icons.woman, "Women's Collection",
                    onTap: (){
                       Get.to(
                           () => CategoryProductsScreen(categoryName: "Women's Ethnic"),
                           transition: Transition.rightToLeft,
                         duration: Duration(seconds: 1)
                       );
                    }
                  ),
                  drawerItem(Icons.shopping_bag, "Accessories",
                    onTap: (){
                       Get.to(
                           () => CategoryProductsScreen(categoryName: "Accessories"),
                           transition: Transition.rightToLeft,
                           duration: Duration(seconds: 1),
                       );
                    }
                  ),

                  const Divider(),

                  drawerItem(Icons.inventory_2, "My Orders",onTap:(){
                    Get.to(
                        () => MyOrders(),
                        transition: Transition.rightToLeft,
                        duration: Duration(seconds: 1),
                    );
                  }),
                  drawerItem(Icons.favorite_border, "Wishlist"),
                  drawerItem(Icons.settings, "Profile Settings"),

                  const Divider(),

                  drawerItem(Icons.help_outline, "Help & Support"),
                  drawerItem(Icons.info_outline, "About"),
                ],
              ),
            ),

            /// 🔴 LOGOUT (BOTTOM FIXED)
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  // ⭐ CLEAR USER CONTROLLER
                  Get.delete<UserController>();

                  // ⭐ GO TO LOGIN SCREEN
                  Get.offAll(() => Login());
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 8),
                      Text("Logout",
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Text("VASTRA ROYALE v2.4.0",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  /// 🔹 MENU ITEM WIDGET
  static Widget drawerItem(IconData icon, String title,
      {bool selected = false, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: selected ? Colors.blue.shade50 : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon,
            color: selected ? Colors.blue : Colors.grey[700]),
        title: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.blue : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
