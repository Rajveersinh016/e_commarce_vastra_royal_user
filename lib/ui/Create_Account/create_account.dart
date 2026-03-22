import 'package:e_commarce_kk/ui/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/auth_controller.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final controller = Get.put(AuthController());

  bool agree = false;

  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final Color primaryColor = const Color(0xFF6C63FF);
  final Color bgColor = const Color(0xFFF5F6FA);

  /// 🔥 INPUT FIELD
  Widget inputField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Create Account",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔥 HEADER
            const SizedBox(height: 10),

            Text(
              "Join Vastra Royale",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Create your account to explore premium fashion",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            /// 🔥 INPUTS
            inputField(
              hint: "Full Name",
              icon: Icons.person_outline,
              controller: namecontroller,
            ),

            inputField(
              hint: "Email Address",
              icon: Icons.email_outlined,
              controller: emailcontroller,
            ),

            inputField(
              hint: "Password",
              icon: Icons.lock_outline,
              controller: passwordcontroller,
            ),

            inputField(
              hint: "Phone Number",
              icon: Icons.phone_outlined,
              controller: phonecontroller,
            ),

            /// 🔥 TERMS
            Row(
              children: [
                Checkbox(
                  activeColor: primaryColor,
                  value: agree,
                  onChanged: (value) {
                    setState(() {
                      agree = value!;
                    });
                  },
                ),
                const Text("I agree to the "),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// 🔥 BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                  if (!agree) {
                    Get.snackbar("Error", "Accept Terms first");
                    return;
                  }

                  if (namecontroller.text.isEmpty ||
                      emailcontroller.text.isEmpty ||
                      passwordcontroller.text.isEmpty ||
                      phonecontroller.text.isEmpty) {
                    Get.snackbar("Error", "All fields required");
                    return;
                  }

                  controller.signup(
                    emailcontroller.text.trim(),
                    passwordcontroller.text.trim(),
                    phonecontroller.text.trim(),
                    namecontroller.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 LOGIN REDIRECT
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Get.to(() => Login());
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}