import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Colors/colors.dart';


class SaleBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const SaleBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.25,
      width: Get.width * 0.90,
      decoration: BoxDecoration(
        color: Appcolor.Sale_back,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),


          Container(
            height: Get.height * 0.20,
            width: Get.width * 0.30,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
