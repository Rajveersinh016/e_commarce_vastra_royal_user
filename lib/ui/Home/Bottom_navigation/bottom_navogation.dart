import 'package:e_commarce_kk/ui/Home/Account/account_page.dart';
import 'package:e_commarce_kk/ui/Home/Catalog/catalog.dart';
import 'package:e_commarce_kk/ui/Home/Home_page/home_page.dart';
import 'package:e_commarce_kk/ui/Home/Wishlist/wishlist.dart';
import 'package:flutter/material.dart';

class BottomNavogation extends StatefulWidget {
  const BottomNavogation({super.key});

  @override
  State<BottomNavogation> createState() => _BottomNavogationState();
}

class _BottomNavogationState extends State<BottomNavogation> {

  int currentIndex = 0;

  final Color primaryColor = const Color(0xFF6C63FF);

  List<Widget> pages = [
    HomePage(),
    Catalog(),
    Wishlist(),
    AccountPage(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            onTap: onTap,
            elevation: 0,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,

            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  currentIndex == 0 ? Icons.home : Icons.home_outlined,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  currentIndex == 1 ? Icons.grid_view : Icons.grid_view_outlined,
                ),
                label: 'Catalog',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  currentIndex == 2 ? Icons.favorite : Icons.favorite_border,
                ),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  currentIndex == 3 ? Icons.person : Icons.person_outline,
                ),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}