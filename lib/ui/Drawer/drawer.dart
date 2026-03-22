import 'package:e_commarce_kk/ui/Category/category_products_screen.dart';
import 'package:e_commarce_kk/ui/Login/login.dart';
import 'package:e_commarce_kk/ui/My_order/my_orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/User_Controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final usecontroller = Get.find<UserController>();

    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4A6EDB), Color(0xFF3E5FB6)],
                ),
              ),
              child: Obx(() {

                final image =
                    usecontroller.user.value?.profileImage ?? "";

                return Row(
                  children: [

                    CircleAvatar(
                      radius: 35,
                      backgroundImage: image.isEmpty
                          ? const AssetImage(
                          "lib/assets/images/Woman.png")
                          : NetworkImage(image)
                      as ImageProvider,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            usecontroller.user.value?.name ??
                                "Loading...",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            "Gold Member",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                children: [

                  drawerItem(Icons.home, "Home", selected: true),

                  drawerItem(Icons.auto_awesome, "New Arrivals"),

                  drawerItem(
                    Icons.man,
                    "Men's Collection",
                    onTap: () {
                      Get.to(
                            () => CategoryProductsScreen(
                            categoryName: "Men's Ethnic"),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                  ),

                  drawerItem(
                    Icons.woman,
                    "Women's Collection",
                    onTap: () {
                      Get.to(
                            () => CategoryProductsScreen(
                            categoryName: "Women's Ethnic"),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                  ),

                  drawerItem(
                    Icons.shopping_bag,
                    "Accessories",
                    onTap: () {
                      Get.to(
                            () => CategoryProductsScreen(
                            categoryName: "Accessories"),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  const Divider(),

                  drawerItem(
                    Icons.inventory_2,
                    "My Orders",
                    onTap: () {
                      Get.to(
                            () => MyOrders(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                  ),

                  drawerItem(Icons.favorite_border, "Wishlist"),
                  drawerItem(Icons.settings, "Profile Settings"),

                  const SizedBox(height: 10),
                  const Divider(),

                  drawerItem(Icons.help_outline, "Help & Support"),
                  drawerItem(Icons.info_outline, "About"),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.delete<UserController>();
                  Get.offAll(() => Login());
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              "VASTRA ROYALE v2.4.0",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  static Widget drawerItem(
      IconData icon,
      String title, {
        bool selected = false,
        VoidCallback? onTap,
      }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: selected
            ? Colors.blue.shade50
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14),
        leading: Icon(
          icon,
          color:
          selected ? Colors.blue : Colors.grey[700],
        ),
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