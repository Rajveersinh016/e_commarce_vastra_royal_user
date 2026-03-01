import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFormField extends StatelessWidget {
  final String title;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const AppFormField({
    super.key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// LABEL
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),

        /// TEXTFIELD
        SizedBox(
          width: Get.width * 0.90,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,



            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, color: Colors.grey),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        const SizedBox(height: 15),
      ],
    );
  }
}







/// 🔵 BUTTON WIDGET (same file)

class AppFormButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const AppFormButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.90,
      height: Get.height * 0.08,

      child: ElevatedButton(
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
