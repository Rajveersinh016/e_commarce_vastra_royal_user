import 'package:e_commarce_kk/Colors/colors.dart';
import 'package:e_commarce_kk/ui/Create_Account/create_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Controller/auth_controller.dart';
import '../Home/Bottom_navigation/bottom_navogation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final controller = Get.put(AuthController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  bool passwordtext = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2746A6), // deep top blue
              Color(0xFF3F6FD8), // mid blue
              Color(0xFF6A9BFF), // bottom light blue


            ],
          ),
        ),

        child: ListView(
          children: [

            Column(
              children: [

                SizedBox(height: 30,),
                Text('WELCOME BACK',style: TextStyle(color: Colors.white70),),

                Container(
                  height: Get.height*0.30,
                  width: Get.width*0.60,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('lib/assets/images/login_1.png'),fit: BoxFit.fill)
                  ),
                ),

                SizedBox(height: 20,),

                SizedBox(
                  width: Get.width*0.85,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'you@example.com',
                      hintStyle: TextStyle(color: Appcolor.hint_text),
                      prefixIcon: Icon(Icons.mail_outline,color: Appcolor.social_bg,),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),

                SizedBox(height: 15,),
                SizedBox(
                  width: Get.width*0.85,
                  child: TextField(
                    controller: passwordController,
                    obscureText: passwordtext,
                    decoration: InputDecoration(
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Appcolor.hint_text),
                        prefixIcon: Icon(Icons.lock_outline,color: Appcolor.social_bg,),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordtext ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed:(){
                            setState(() {
                              passwordtext = !passwordtext;
                            });
                          } ,
                        )
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 170.0),
                  child: TextButton(
                      onPressed: (){
                        if(emailController.text.trim().isEmpty){
                          Get.snackbar("Error", "Enter your email",backgroundColor: Colors.red,colorText: Colors.white);
                        }
                        else{
                          controller.forgotpassword(emailController.text);
                        }
                      },
                      child: Text('Forogot Password?',style: TextStyle(color:Colors.white),)
                  ),
                ),

                SizedBox(height: 5,),
                SizedBox(
                  width: Get.width*0.85,
                  child: ElevatedButton(
                      onPressed: (){
                        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                          Get.snackbar("Error", "All fields required");
                          return;
                        }

                        controller.signin(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      child:Text('SIGN IN',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                ),

                SizedBox(height: 10,),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [

                      Expanded(
                        child: Divider(
                          color: Colors.white38,
                          thickness: 1,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        "Or continue with",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Divider(
                          color: Colors.white38,
                          thickness: 1,
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.g_mobiledata),
                        color: Colors.white,
                        iconSize: 32,
                      ),
                    ),

                    SizedBox(width: 20,),

                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15), // background
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.facebook),
                        color: Colors.white,
                        iconSize: 32,
                      ),
                    )




                  ],
                ),
                
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New to Vastra Royal?',style: TextStyle(color: Colors.white70),),
                    TextButton(onPressed: (){
                      Get.to(
                          () => CreateAccount(),
                          transition: Transition.rightToLeft,
                          duration: Duration(seconds: 1)
                      );
                    },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(left: 5),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child:Text('Sign Up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                  ],
                )



              ],
            )

          ],
        ),
      ),
    );
  }
}
