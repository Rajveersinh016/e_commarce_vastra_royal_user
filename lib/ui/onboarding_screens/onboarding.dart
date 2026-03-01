import 'package:e_commarce_kk/ui/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  // controller to swipe pages
  final PageController pageController = PageController();

  // current page index
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


      body: PageView(
        controller: pageController,

        // this runs when user swipes page
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        children: [


          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  Container(
                    height: Get.height * 0.40,
                    width: Get.width * 0.85,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/onboarding-1.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Discover',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),

                  const Text(
                    'Latest Products',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: Get.width * 0.60,
                    child: const Text(
                      'Explore premium clothing with trusted quality',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),


          //second page

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  Container(
                    height: Get.height * 0.40,
                    width: Get.width * 0.85,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/onboarding-2.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Shop Easy &',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),

                  const Text(
                    'Fast',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: Get.width * 0.60,
                    child: const Text(
                      'Add to cart, order quickly and get delivery',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [

              /// LEFT → SKIP
              TextButton(
                onPressed: () {
                  Get.offAll(Login());
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),

              /// CENTER → DOTS
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2, // number of pages
                        (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentIndex == i ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? Colors.blue
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              /// RIGHT → ARROW OR BUTTON
              currentIndex == 1
                  ? ElevatedButton(
                onPressed: () {
                  Get.offAll(Login());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Get Started",style: TextStyle(color: Colors.white),),
              )
                  : IconButton(
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }
}






