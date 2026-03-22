import 'package:e_commarce_kk/Colors/colors.dart';
import 'package:e_commarce_kk/ui/Custom_Widget/Profile_header.dart';
import 'package:e_commarce_kk/ui/Home/Account/Payment_Method/payment_method.dart';
import 'package:e_commarce_kk/ui/Home/Account/Shipping_Address/shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Edit_Profile/edit_profile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  /// REUSABLE MENU TILE
  Widget menuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        decoration: BoxDecoration(
          color: Appcolor.light_grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [

            Icon(icon, color: Colors.blueAccent),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),

            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  /// STATS CARD
  Widget statCard({
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Appcolor.light_grey,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none,
                color: Colors.black),
          )
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [

          const SizedBox(height: 10),

          /// PROFILE HEADER
          const Center(child: ProfileHeader()),

          const SizedBox(height: 20),

          /// STATS
          Row(
            children: const [
              Expanded(child: SizedBox()),
            ],
          ),

          Row(
            children: [
              statCard(value: "12", label: "ORDERS"),
              const SizedBox(width: 12),
              statCard(value: "240", label: "POINTS"),
            ],
          ),

          const SizedBox(height: 20),

          /// SECTION TITLE
          const Text(
            "ACCOUNT",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 10),

          /// MENU ITEMS
          menuTile(
            icon: Icons.person,
            title: "Edit Profile",
            onTap: () {
              Get.to(
                    () => EditProfile(),
                transition: Transition.rightToLeft,
              );
            },
          ),

          menuTile(
            icon: Icons.local_shipping_outlined,
            title: "Shipping Address",
            onTap: () {
              Get.to(
                    () => ShippingAddress(),
                transition: Transition.rightToLeft,
              );
            },
          ),

          menuTile(
            icon: Icons.credit_card_outlined,
            title: "Payment Method",
            onTap: () {
              Get.to(
                    () => PaymentMethod(),
                transition: Transition.rightToLeft,
              );
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}