import 'dart:async';
import 'package:e_commarce_kk/ui/auth_checker/auth_checker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  final Color primaryColor = const Color(0xFF6C63FF);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnim =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scaleAnim =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(const AuthChecker());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,

        /// 🔥 SOFT GRADIENT BACKGROUND
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF7F8FC),
              Color(0xFFEDEEFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const SizedBox(height: 20),

              /// 🔥 CENTER CONTENT
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    /// 🔥 LOGO WITH DEPTH
                    ScaleTransition(
                      scale: _scaleAnim,
                      child: FadeTransition(
                        opacity: _fadeAnim,
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor.withOpacity(0.15),
                                primaryColor.withOpacity(0.05),
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.15),
                                blurRadius: 25,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.shopping_bag,
                            size: 60,
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// 🔥 BRAND NAME
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: const Text(
                        "VASTRA ROYALE",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Text(
                        "Discover Your Style",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 🔽 LOADING SECTION
              Column(
                children: [

                  SizedBox(
                    width: 120,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey.shade300,
                      color: primaryColor,
                      minHeight: 4,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}