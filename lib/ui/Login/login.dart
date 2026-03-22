import 'package:e_commarce_kk/ui/Create_Account/create_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/auth_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>
    with SingleTickerProviderStateMixin {

  final controller = Get.put(AuthController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;

  late AnimationController _controllerAnim;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  final Color primaryColor = const Color(0xFF6C63FF);

  @override
  void initState() {
    super.initState();

    _controllerAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(parent: _controllerAnim, curve: Curves.easeIn);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(_controllerAnim);

    _controllerAnim.forward();
  }

  @override
  void dispose() {
    _controllerAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF8F9FF),
              Color(0xFFEDEEFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              const SizedBox(height: 40),

              /// 🔥 LOGO
              FadeTransition(
                opacity: _fade,
                child: Column(
                  children: [

                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor,
                            primaryColor.withOpacity(0.7),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "VASTRA ROYALE",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "Welcome back 👋",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// 🔥 FORM
              Expanded(
                child: SlideTransition(
                  position: _slide,
                  child: FadeTransition(
                    opacity: _fade,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(20),

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

                        child: Column(
                          children: [

                            /// EMAIL
                            _inputField(
                              hint: "Email Address",
                              icon: Icons.email_outlined,
                              controller: emailController,
                            ),

                            /// PASSWORD
                            _inputField(
                              hint: "Password",
                              icon: Icons.lock_outline,
                              controller: passwordController,
                              isPassword: true,
                            ),

                            /// FORGOT PASSWORD
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  if (emailController.text.trim().isEmpty) {
                                    Get.snackbar("Error", "Enter email first");
                                  } else {
                                    controller.forgotpassword(
                                        emailController.text.trim());
                                  }
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: primaryColor),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            /// 🔥 LOGIN BUTTON (LOGIC RESTORED)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {

                                  if (emailController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    Get.snackbar("Error", "All fields required");
                                    return;
                                  }

                                  controller.signin(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
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
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            /// DIVIDER
                            Row(
                              children: const [
                                Expanded(child: Divider()),
                                SizedBox(width: 10),
                                Text("or"),
                                SizedBox(width: 10),
                                Expanded(child: Divider()),
                              ],
                            ),

                            const SizedBox(height: 20),

                            /// GOOGLE BUTTON (UI ONLY)
                            Container(
                              height: 55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.g_mobiledata, size: 30),
                                  SizedBox(width: 10),
                                  Text(
                                    "Continue with Google",
                                    style: TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),

                            const SizedBox(height: 25),

                            /// SIGN UP
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don’t have an account? "),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const CreateAccount());
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? obscure : false,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.grey),
          hintText: hint,
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              obscure
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                obscure = !obscure;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}