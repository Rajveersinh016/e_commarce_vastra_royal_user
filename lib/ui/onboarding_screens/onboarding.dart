import 'package:e_commarce_kk/ui/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  final PageController pageController = PageController();
  int currentIndex = 0;

  final Color primaryColor = const Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [

          /// 🔥 PAGE VIEW
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },

              children: [

                /// 🔥 PAGE 1
                _buildPage(
                  image: 'lib/assets/images/onboarding-1.png',
                  title1: "Discover",
                  title2: "Latest Fashion",
                  subtitle:
                  "Explore premium clothing with trusted quality and style.",
                ),

                /// 🔥 PAGE 2
                _buildPage(
                  image: 'lib/assets/images/onboarding-2.png',
                  title1: "Shop Easy &",
                  title2: "Fast Delivery",
                  subtitle:
                  "Add to cart, checkout quickly and get doorstep delivery.",
                ),
              ],
            ),
          ),

          /// 🔽 BOTTOM NAV
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 20),
            child: Row(
              children: [

                /// SKIP
                TextButton(
                  onPressed: () {
                    Get.offAll(const Login());
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                        color: Colors.grey, fontSize: 16),
                  ),
                ),

                /// DOTS
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                          (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin:
                        const EdgeInsets.symmetric(horizontal: 4),
                        width: currentIndex == i ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentIndex == i
                              ? primaryColor
                              : Colors.grey.shade300,
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),

                /// NEXT / GET STARTED
                currentIndex == 1
                    ? ElevatedButton(
                  onPressed: () {
                    Get.offAll(const Login());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      pageController.nextPage(
                        duration:
                        const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 🔥 PAGE BUILDER
  Widget _buildPage({
    required String image,
    required String title1,
    required String title2,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// IMAGE
          Container(
            height: Get.height * 0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// TITLE
          Text(
            title1,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            title2,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          const SizedBox(height: 12),

          /// SUBTITLE
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}