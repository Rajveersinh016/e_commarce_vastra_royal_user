import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Home/Bottom_navigation/bottom_navogation.dart';
import '../onboarding_screens/onboarding.dart';


class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return BottomNavogation();
    } else {
      return Onboarding();
    }
  }
}