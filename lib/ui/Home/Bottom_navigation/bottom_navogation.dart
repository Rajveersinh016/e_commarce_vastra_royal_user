import 'package:e_commarce_kk/Colors/colors.dart';
import 'package:e_commarce_kk/ui/Home/Account/account_page.dart';

import 'package:e_commarce_kk/ui/Home/Catalog/catalog.dart';
import 'package:e_commarce_kk/ui/Home/Home_page/home_page.dart';

import 'package:e_commarce_kk/ui/Home/Wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:e_commarce_kk/ui/Home/Catalog/catalog.dart';
import 'package:e_commarce_kk/ui/Home/Wishlist/wishlist.dart';


class BottomNavogation extends StatefulWidget {
  const BottomNavogation({super.key});

  @override
  State<BottomNavogation> createState() => _BottomNavogationState();
}

class _BottomNavogationState extends State<BottomNavogation> {

  int currentIndex = 0;

  List <Widget> pages = [
    HomePage(),
    Catalog(),
    Wishlist(),
    AccountPage(),
  ];

void onTap(int index){
  setState(() {
    currentIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,



      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // IMPORTANT
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: onTap,

        selectedItemColor: Colors.black,     // visible on black
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Catalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),


    );
  }
}
